# Install Prompt

Copy everything below and paste it into Codex.

```text
You are Codex on Windows. Set up Obsidian Brain as my personal note system.

Main goal:
- Install Obsidian if it is not installed.
- Create the Obsidian vault `C:\Codex\BRAIN`.
- Create the basic note structure.
- Add global Brain commands to Codex AGENTS.md.

Important:
- Use only the official Obsidian installation source.
- Preferred installation method: winget.
- Do not use MCP.
- Do not overwrite existing personal notes.
- If anything is unclear or risky, stop and explain before changing files.

Step 1. Install Obsidian

1. Check whether Obsidian is installed.
2. Check whether winget is available.
3. If Obsidian is not installed and winget is available, install Obsidian with:

winget install --id Obsidian.Obsidian -e --accept-package-agreements --accept-source-agreements

4. Wait until installation finishes.
5. Verify that Obsidian is installed.
6. If winget is unavailable or installation fails:
   - stop;
   - explain that Obsidian must be downloaded only from the official website:
     https://obsidian.md/download
   - ask the user to install the Windows installer manually;
   - ask the user to return to chat and write "done";
   - then continue.

Step 2. Create the vault

1. Create this folder:

C:\Codex\BRAIN

2. Create this folder inside it:

C:\Codex\BRAIN\.obsidian

3. If Obsidian requires opening the vault manually:
   - stop;
   - explain:
     "Open Obsidian -> Open folder as vault -> choose C:\Codex\BRAIN -> click Open."
   - ask the user to return and write "done".

Step 3. Create the structure

Create these folders:

00 Inbox
10 Work
20 Career
30 Knowledge
40 People
40 People\Friends
40 People\Colleagues
40 People\Professional Contacts
40 People\Recruiters
40 People\New Contacts
50 Personal
50 Personal\Family
50 Personal\Rest
50 Personal\Health
50 Personal\Home
50 Personal\Hobbies
50 Personal\Hobbies\Active
50 Personal\Hobbies\Ideas
50 Personal\Hobbies\Learning
90 Templates

Step 4. Create starter notes

Create markdown files with basic content:

Home.md
00 Inbox\Inbox.md
10 Work\Work Dashboard.md
20 Career\Career Dashboard.md
20 Career\Achievements.md
20 Career\CV Notes.md
20 Career\LinkedIn Ideas.md
20 Career\Interview Prep.md
20 Career\Job Search.md
30 Knowledge\Knowledge Dashboard.md
40 People\People Dashboard.md
40 People\Friends\Friends Dashboard.md
40 People\Colleagues\Colleagues Dashboard.md
40 People\Professional Contacts\Professional Contacts Dashboard.md
40 People\Recruiters\Recruiters Dashboard.md
40 People\New Contacts\New Contacts Dashboard.md
50 Personal\Personal Dashboard.md
50 Personal\Family\Family Dashboard.md
50 Personal\Family\Daughter.md
50 Personal\Family\Wife.md
50 Personal\Family\Mom.md
50 Personal\Family\Dad.md
50 Personal\Family\Parents.md
50 Personal\Rest\Rest Dashboard.md
50 Personal\Health\Health Dashboard.md
50 Personal\Home\Home Dashboard.md
50 Personal\Hobbies\Hobbies Dashboard.md
50 Personal\Hobbies\Active\Active Hobbies.md
50 Personal\Hobbies\Ideas\Hobby Ideas.md
50 Personal\Hobbies\Learning\Hobby Learning.md
90 Templates\Person Template.md
90 Templates\Family Person Template.md
90 Templates\Friend Template.md
90 Templates\Colleague Template.md
90 Templates\Recruiter Template.md
90 Templates\Professional Contact Template.md
90 Templates\Meeting Template.md
90 Templates\Career Story Template.md
90 Templates\Hobby Template.md

Step 5. Global Codex commands

Find the global Codex AGENTS.md file, usually:

C:\Users\<USERNAME>\.codex\AGENTS.md

If the file does not exist, create it.
If the file exists, do not delete old rules. Append this new section to the end.

Add this section:

## Brain / Obsidian Capture

Main Obsidian vault:
`C:\Codex\BRAIN`

In user commands, `Brain`, `мозг`, and `Obsidian` refer to this vault.

Recognize these commands:
- `save to Brain`, `add to Brain`, `store in Brain`, `capture in Brain`, `write to Brain`
- `запиши в Brain`, `добавь в Brain`, `сохрани в Brain`, `внеси в Brain`
- `запиши в мозг`, `добавь в мозг`, `сохрани в мозг`, `внеси в мозг`
- `analyze this chat into Brain`, `save useful parts of this chat to Brain`, `sort this chat into Brain`
- `разбери этот чат в Brain`, `разбери этот чат в мозг`
- `разнеси этот чат по Brain`, `разнеси этот чат по мозгу`
- `analyze this project into Brain`, `save project context to Brain`
- `разбери проект в Brain`, `разбери проект в мозг`
- `check Brain for topic`, `проверь Brain по теме`, `проверь мозг по теме`
- `add to Inbox`, `добавь в Inbox`, `разбери Inbox`
- `show me what you will save first`, `сначала покажи, что сохранишь`
- `save only after confirmation`, `сохрани только после подтверждения`
- `do not save this`, `не сохраняй это`

Rules:
- Save only durable useful content: facts, tasks, decisions, plans, contacts, ideas, conclusions, progress, difficulties, preferences, stable context.
- Do not save whole conversations verbatim unless explicitly asked.
- Do not save every casual phrase automatically.
- Do not invent missing details.
- Use Obsidian wikilinks where helpful.
- Check relevant Brain notes before answering when saved context may matter.

Deduplication and updates:
- Before creating a new Brain note, search the relevant Brain section for an existing note about the same person, topic, project, recipe, contact, task, or recurring area.
- If a matching note exists, update that note instead of creating a duplicate.
- If the new information is an event, observation, lesson, or progress update related to an existing note, append it under a dated section.
- If the new information changes or corrects older information, preserve the correction clearly instead of silently overwriting history.
- If multiple plausible target notes exist, ask the user or save to `00 Inbox` with a note that it needs sorting.
- Create a new note only when no suitable existing note exists.

Routing:
- Career/CV/jobs/interviews/LinkedIn -> `20 Career`
- Work/projects/working decisions -> `10 Work`
- Knowledge/learning/ideas/reference -> `30 Knowledge`
- Friends/colleagues/recruiters/professional contacts -> `40 People`
- Family/rest/health/home/hobbies -> `50 Personal`
- Raw or unclear information -> `00 Inbox`

Emerging sections:
- If new information does not fit the current Brain structure, do not force it into a wrong folder.
- For the first one-off item, save it in the closest suitable section or `00 Inbox`.
- If similar information appears repeatedly, propose a dedicated new branch.
- Explain why the branch is useful and what would move there.
- Create the new folder/structure only after user confirmation, except for small notes inside already existing folders.

Safety:
- Never delete or rewrite personal notes without explicit permission.
- If the user says `show me what you will save first` or `сначала покажи, что сохранишь`, show proposed saved items and target files first, then wait for confirmation.
- If the user says `save only after confirmation` or `сохрани только после подтверждения`, do not write files until the user confirms.
- If the user says `do not save this` or `не сохраняй это`, do not add the current information to Brain.
- For delete requests, first show what would be deleted and wait for confirmation.

Step 6. Verification

At the end, verify and report:
- whether Obsidian is installed;
- whether `C:\Codex\BRAIN` exists;
- whether the folder structure exists;
- whether `Home.md` exists;
- whether `Brain / Obsidian Capture` was added to global AGENTS.md.

If something failed, explain simply what failed and what the next step is.
```

