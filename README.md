# Task Tracking System

A folder-based task tracking system for software development projects. Track work across multiple developers with automatic username detection, per-developer task numbering, and comprehensive documentation.

## Features

- ✅ **Automatic Username Detection** - Extracts from git config (no manual input)
- ✅ **Per-Developer Task Numbering** - Each developer maintains their own sequence
- ✅ **Auto-Grouping** - Files sort alphabetically by developer
- ✅ **Git-Native** - Uses existing git configuration
- ✅ **Project-Agnostic** - Works with any language/framework
- ✅ **AI-Friendly** - Designed for Claude Code and other AI assistants
- ✅ **Zero Dependencies** - Pure bash script + markdown files

## Quick Start

### Prerequisites

1. **First**: Open your project in Claude Code and run `/init` command
   - This creates `CLAUDE.md` with your project documentation
2. **Then**: Run the installation command below

### Installation

```bash
cd /path/to/your-project
curl -sSL https://raw.githubusercontent.com/MakeApps/task-tracking/main/init-task-tracking.sh | bash
```

## What Gets Installed

```
your-project/
├── task/                              # Active tasks folder
│   ├── README.md                      # Documentation
│   └── completed_task/                # Archived completed tasks
│       └── README.md                  # Archive documentation
└── CLAUDE.md                          # Updated with task tracking workflow
```

After installation, just say **"new task"** to Claude Code to get started!

## Usage

### Starting a New Task

1. Say **"new task"** to Claude Code
2. Claude auto-detects your username from `git config user.name`
3. Provide task name and description
4. Claude creates:
   - Branch: `task/username-001-description`
   - File: `task/task-username-001-description.md`
   - Commits with: `task-username-001: message`

### Task File Examples

**Files automatically group by developer:**
```
task/
├── task-alice-001-add-authentication.md
├── task-alice-002-implement-profile.md
├── task-bob-001-fix-search-bug.md
├── task-bob-002-optimize-queries.md
└── task-claude-001-refactor-api.md
```

### Completing a Task

1. Work on the task, commit frequently
2. Push to task branch
3. Developer reviews and approves
4. Say **"completed"** or **"mark complete"**
5. Claude moves file to `task/completed_task/`

## Requirements

- Git repository with `user.name` or `user.email` configured
- Claude Code (recommended AI assistant)

## Troubleshooting

### "Git user.name not configured"

```bash
git config --global user.name "Your Name"
```

### "CLAUDE.md not found"

Run the init slash command in Claude Code first, then re-run installer.

### "Task tracking section already exists"

Already installed! No action needed.

### Permission Denied

```bash
chmod +x init-task-tracking.sh
```

---

**Ready to install?** Run the installation command above in your project directory!
