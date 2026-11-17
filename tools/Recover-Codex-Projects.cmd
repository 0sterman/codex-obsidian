@echo off
title Codex local project recovery
echo.
echo Codex must be fully closed before recovery starts.
echo This PowerShell window will remain open so you can read the result.
echo.
powershell.exe -NoProfile -NoExit -ExecutionPolicy Bypass -File "%~dp0Recover-Codex-Projects.ps1"