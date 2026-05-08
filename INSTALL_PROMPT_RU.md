# Установочный Промт

Скопируй все ниже и вставь в Codex.

```text
Ты Codex на Windows. Настрой мне Obsidian Brain как личную систему заметок.

Главная цель:
- Установить Obsidian, если он еще не установлен.
- Создать Obsidian vault `C:\Codex\BRAIN`.
- Создать базовую структуру заметок.
- Добавить глобальные команды Brain в Codex AGENTS.md.

Важно:
- Используй только официальный источник установки Obsidian.
- Предпочтительный способ установки: winget.
- Не используй MCP.
- Не перезаписывай существующие личные заметки.
- Если что-то неясно или рискованно, остановись и объясни перед изменениями.

Шаг 1. Установка Obsidian

1. Проверь, установлен ли Obsidian.
2. Проверь, доступен ли winget.
3. Если Obsidian не установлен и winget доступен, установи Obsidian командой:

winget install --id Obsidian.Obsidian -e --accept-package-agreements --accept-source-agreements

4. Дождись завершения установки.
5. Проверь, что Obsidian установлен.
6. Если winget недоступен или установка не сработала:
   - остановись;
   - объясни пользователю, что нужно скачать Obsidian только с официального сайта:
     https://obsidian.md/download
   - попроси установить Windows installer вручную;
   - попроси вернуться в чат и написать "готово";
   - после этого продолжи.

Шаг 2. Создание vault

1. Создай папку:

C:\Codex\BRAIN

2. Создай внутри нее папку:

C:\Codex\BRAIN\.obsidian

3. Если Obsidian требует открыть vault вручную:
   - остановись;
   - объясни пользователю:
     "Открой Obsidian -> Open folder as vault / Открыть папку как хранилище -> выбери C:\Codex\BRAIN -> нажми Open."
   - попроси вернуться и написать "готово".

Шаг 3. Создание структуры

Создай папки:

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

Шаг 4. Создание стартовых заметок

Создай markdown-файлы с базовым содержанием:

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

Шаг 5. Глобальные команды Codex

Найди глобальный файл Codex AGENTS.md, обычно:

C:\Users\<USERNAME>\.codex\AGENTS.md

Если файла нет - создай его.
Если файл есть - не удаляй старые правила, добавь новый раздел в конец.

Добавь раздел:

## Brain / Obsidian Capture

Main Obsidian vault:
`C:\Codex\BRAIN`

In user commands, `Brain`, `мозг`, and `Obsidian` refer to this vault.

Recognize these commands:
- `запиши в Brain`, `добавь в Brain`, `сохрани в Brain`, `внеси в Brain`
- `запиши в мозг`, `добавь в мозг`, `сохрани в мозг`, `внеси в мозг`
- `разбери этот чат в Brain`, `разбери этот чат в мозг`
- `разнеси этот чат по Brain`, `разнеси этот чат по мозгу`
- `разбери проект в Brain`, `разбери проект в мозг`
- `проверь Brain по теме`, `проверь мозг по теме`
- `добавь в Inbox`, `разбери Inbox`
- `сначала покажи, что сохранишь`
- `сохрани только после подтверждения`
- `не сохраняй это`

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
- If the user says `сначала покажи, что сохранишь`, show proposed saved items and target files first, then wait for confirmation.
- If the user says `сохрани только после подтверждения`, do not write files until the user confirms.
- If the user says `не сохраняй это`, do not add the current information to Brain.
- For `удали из Brain`, `удали из мозга`, or similar delete requests, first show what would be deleted and wait for confirmation.

Шаг 6. Проверка

В конце проверь и сообщи:
- установлен ли Obsidian;
- существует ли `C:\Codex\BRAIN`;
- создана ли структура папок;
- создан ли `Home.md`;
- добавлен ли раздел `Brain / Obsidian Capture` в глобальный AGENTS.md.

Если что-то не получилось, объясни простыми словами, что именно и какой следующий шаг.
```

