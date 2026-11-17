[CmdletBinding()]
param(
    [string]$CodexHome = (Join-Path $env:USERPROFILE '.codex'),
    [string]$Sqlite3Path = 'sqlite3.exe'
)

$ErrorActionPreference = 'Stop'

function Convert-JsonRows {
    param([Parameter(Mandatory = $true)][string]$Json)
    $parsed = ConvertFrom-Json -InputObject $Json
    if ($parsed -is [array]) { $parsed } else { @($parsed) }
}

function Write-AtomicUtf8 {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Text
    )
    $tmp = "$Path.codex-recovery.tmp"
    [System.IO.File]::WriteAllText($tmp, $Text, [System.Text.UTF8Encoding]::new($false))
    Move-Item -LiteralPath $tmp -Destination $Path -Force
}

$statePath = Join-Path $CodexHome '.codex-global-state.json'
$bakPath = Join-Path $CodexHome '.codex-global-state.json.bak'
$dbPath = Join-Path $CodexHome 'state_5.sqlite'
$backupDir = Join-Path $CodexHome 'backups'
$hostKey = 'local:' + $CodexHome

$running = @(Get-Process -Name 'ChatGPT','codex' -ErrorAction SilentlyContinue)
if ($running.Count -gt 0) {
    throw 'Codex is still running. Exit Codex completely (Ctrl+Q), then run this script again.'
}
if (-not (Test-Path -LiteralPath $statePath)) { throw "Missing state file: $statePath" }
if (-not (Test-Path -LiteralPath $dbPath)) { throw "Missing SQLite database: $dbPath" }

$sqlite = Get-Command $Sqlite3Path -ErrorAction SilentlyContinue
if ($null -eq $sqlite) {
    throw "sqlite3.exe was not found on PATH. Re-run with -Sqlite3Path <full path to sqlite3.exe>."
}
$sqliteExe = $sqlite.Source

$quick = (& $sqliteExe -readonly $dbPath 'PRAGMA quick_check;' | Out-String).Trim()
if ($quick -ne 'ok') { throw "SQLite quick_check failed: $quick" }

$projectJson = (& $sqliteExe -readonly -json $dbPath 'SELECT id,name,position,created_at_ms,updated_at_ms FROM projects ORDER BY position,id;' | Out-String).Trim()
$rootJson = (& $sqliteExe -readonly -json $dbPath 'SELECT project_id,position,path FROM project_roots ORDER BY project_id,position;' | Out-String).Trim()
$keyJson = (& $sqliteExe -readonly -json $dbPath 'SELECT key,project_id FROM project_idempotency_keys ORDER BY created_at_ms;' | Out-String).Trim()

$projects = @(Convert-JsonRows $projectJson)
$roots = @(Convert-JsonRows $rootJson)
$keys = @(Convert-JsonRows $keyJson)
if ($projects.Count -eq 0 -or $roots.Count -eq 0 -or $keys.Count -eq 0) {
    throw 'SQLite project catalog is incomplete; no changes were made.'
}

$legacyByServer = @{}
foreach ($row in $keys) {
    $serverId = [string]$row.project_id
    if ($legacyByServer.ContainsKey($serverId)) { throw "Duplicate idempotency mapping for $serverId" }
    $legacyByServer[$serverId] = [string]$row.key
}

$rootsByServer = @{}
foreach ($row in $roots) {
    $serverId = [string]$row.project_id
    if (-not $rootsByServer.ContainsKey($serverId)) {
        $rootsByServer[$serverId] = New-Object System.Collections.Generic.List[string]
    }
    $rootsByServer[$serverId].Add([string]$row.path)
}

$catalog = [ordered]@{}
$order = New-Object System.Collections.Generic.List[string]
$mappingForHost = [ordered]@{}

foreach ($row in $projects) {
    $serverId = [string]$row.id
    if (-not $legacyByServer.ContainsKey($serverId)) {
        throw "Project has no legacy idempotency key: $($row.name) / $serverId"
    }
    if (-not $rootsByServer.ContainsKey($serverId) -or $rootsByServer[$serverId].Count -eq 0) {
        throw "Project has no root path: $($row.name) / $serverId"
    }

    $legacyId = $legacyByServer[$serverId]
    if ($catalog.Contains($legacyId)) { throw "Duplicate legacy project id: $legacyId" }

    $catalog[$legacyId] = [ordered]@{
        id = $legacyId
        name = [string]$row.name
        rootPaths = @($rootsByServer[$serverId])
        createdAt = [int64]$row.created_at_ms
        updatedAt = [int64]$row.updated_at_ms
    }
    $order.Add($legacyId)
    $mappingForHost[$legacyId] = $serverId
}

$current = ConvertFrom-Json -InputObject ([System.IO.File]::ReadAllText($statePath))
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
[System.IO.Directory]::CreateDirectory($backupDir) | Out-Null
$backupState = Join-Path $backupDir "global-state-before-codex-project-recovery-$stamp.json"
[System.IO.File]::Copy($statePath, $backupState, $false)

$completed = @($current.'electron-completed-local-data-migration-ids' | Where-Object {
    $_ -notin @('2026-07-13-local-projects','2026-07-14-repair-metadata-local-projects')
})
$current | Add-Member -MemberType NoteProperty -Name 'electron-completed-local-data-migration-ids' -Value $completed -Force

$migrationProperty = @($current.PSObject.Properties | Where-Object {
    $_.Name -like 'electron-owner-value:app-server-projects-migration-by-host:*'
}) | Select-Object -First 1
if ($null -eq $migrationProperty) {
    throw 'The app-server migration marker was not found; no changes were made.'
}
$migrationKey = $migrationProperty.Name
$markers = $migrationProperty.Value
$hostMarker = $markers.PSObject.Properties[$hostKey].Value
if ($null -eq $hostMarker) { $hostMarker = [pscustomobject]@{} }
$hostMarker | Add-Member -MemberType NoteProperty -Name 'version' -Value 1 -Force
$hostMarker | Add-Member -MemberType NoteProperty -Name 'projectsMigrated' -Value $false -Force
$hostMarker | Add-Member -MemberType NoteProperty -Name 'threadAssignmentsMigrated' -Value $false -Force
$markers | Add-Member -MemberType NoteProperty -Name $hostKey -Value $hostMarker -Force
$current | Add-Member -MemberType NoteProperty -Name $migrationKey -Value $markers -Force

$current | Add-Member -MemberType NoteProperty -Name 'local-projects' -Value $catalog -Force
$current | Add-Member -MemberType NoteProperty -Name 'project-order' -Value @($order) -Force

$maps = $current.PSObject.Properties['app-server-project-id-by-legacy-project-id-by-host'].Value
if ($null -eq $maps) { $maps = [pscustomobject]@{} }
$maps | Add-Member -MemberType NoteProperty -Name $hostKey -Value $mappingForHost -Force
$current | Add-Member -MemberType NoteProperty -Name 'app-server-project-id-by-legacy-project-id-by-host' -Value $maps -Force

$updatedJson = $current | ConvertTo-Json -Compress -Depth 100
Write-AtomicUtf8 -Path $statePath -Text $updatedJson
Write-AtomicUtf8 -Path $bakPath -Text $updatedJson

$check = ConvertFrom-Json -InputObject ([System.IO.File]::ReadAllText($statePath))
[pscustomobject]@{
    Status = 'completed'
    SQLiteQuickCheck = $quick
    RestoredProjects = @($check.'local-projects'.PSObject.Properties).Count
    RestoredOrder = @($check.'project-order').Count
    BackupState = $backupState
    Message = 'Start Codex again. Projects should reappear automatically.'
} | ConvertTo-Json -Compress