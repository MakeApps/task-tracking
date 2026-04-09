# Task Tracking System

A folder-based task tracking system for software development projects. Track work across multiple developers with automatic username detection, per-developer task numbering, and comprehensive documentation.

## Features

✅ **Automatic Username Detection** - Extracts from git config (no manual input)
✅ **Per-Developer Task Numbering** - Each developer maintains their own sequence
✅ **Auto-Grouping** - Files sort alphabetically by developer
✅ **Git-Native** - Uses existing git configuration
✅ **Project-Agnostic** - Works with any language/framework
✅ **AI-Friendly** - Designed for Claude Code and other AI assistants
✅ **Zero Dependencies** - Pure bash script + markdown files

## Quick Start

### Method 1: Automated Installation (Recommended)

```bash
cd /path/to/your-project
curl -sSL https://raw.githubusercontent.com/MakeApps/task-tracking/main/init-task-tracking.sh | bash
```

### Method 2: Clone and Install

```bash
# Clone this repository
git clone https://github.com/MakeApps/task-tracking.git /tmp/task-tracking

# Navigate to your project
cd /path/to/your-project

# Run installer
/tmp/task-tracking/init-task-tracking.sh
```

### Method 3: Download and Run Locally

```bash
# Download the installer
curl -O https://raw.githubusercontent.com/MakeApps/task-tracking/main/init-task-tracking.sh

# Make it executable
chmod +x init-task-tracking.sh

# Run it
./init-task-tracking.sh
```

## Installation Workflow

### For Projects WITH Existing CLAUDE.md

```bash
# 1. Run installer (automatically appends task tracking section)
./init-task-tracking.sh

# 2. Commit changes
git commit -m "Add task tracking system"

# 3. Start using
# Say "new task" to Claude Code!
```

### For Projects WITHOUT CLAUDE.md (New Projects)

```bash
# 1. Run installer (creates task folders)
./init-task-tracking.sh

# 2. In Claude Code: Run /init command
# This analyzes your project and creates CLAUDE.md

# 3. Run installer again (appends task tracking section)
./init-task-tracking.sh

# 4. Commit everything
git commit -m "Add project documentation and task tracking system"

# 5. Start using
# Say "new task" to Claude Code!
```

## What Gets Installed

The installer creates:

```
your-project/
├── task/                              # Active tasks
│   ├── README.md                      # Documentation
│   └── completed_task/                # Archived tasks
│       └── README.md                  # Archive documentation
└── CLAUDE.md                          # Updated with task tracking section
```

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

- **Git**: Must be a git repository
- **Git Config**: `user.name` or `user.email` configured
- **Claude Code**: Recommended AI assistant (works with others too)

## Configuration

### Git Config Setup

```bash
# Set your name (required)
git config --global user.name "Your Name"

# Or set your email (fallback)
git config --global user.email "you@example.com"
```

The system automatically:
- Extracts username from `git config user.name`
- Fallback to email username (before @) if name not set
- Sanitizes: lowercase, removes spaces/special chars

## Features in Detail

### Automatic Username Detection

No manual input required! The system automatically:

1. Runs `git config user.name`
2. Sanitizes the result (lowercase, remove spaces)
3. Uses it for task files and branches

Examples:
- "Alice Smith" → "alicesmith"
- "bob.jones" → "bobjones"
- "dev-123" → "dev123"

### Per-Developer Numbering

Each developer maintains their own sequence:
- Alice: 001, 002, 003...
- Bob: 001, 002, 003...
- Claude: 001, 002, 003...

No conflicts! Multiple developers can create task-001 simultaneously.

### File Organization

Files automatically sort by developer:
```bash
# List all tasks by Alice
ls task/task-alice-*

# List all completed tasks by Bob
ls task/completed_task/task-bob-*
```

## Manual Installation (Alternative)

If you prefer manual setup:

1. **Create folders:**
   ```bash
   mkdir -p task/completed_task
   ```

2. **Copy README files:**
   ```bash
   cp templates/task-README.md task/README.md
   cp templates/completed-README.md task/completed_task/README.md
   ```

3. **Append to CLAUDE.md:**
   ```bash
   cat TASK_TRACKING_TEMPLATE.md >> CLAUDE.md
   ```

4. **Commit:**
   ```bash
   git add task/ CLAUDE.md
   git commit -m "Add task tracking system"
   ```

## Distribution

### For Your Company

**Option A: Internal Git Repository**
```bash
# Host on GitHub/GitLab
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/MakeApps/task-tracking.git
git push -u origin main
```

**Option B: Copy to Projects**
```bash
# Copy entire folder to new project
cp -r task-tracking-system/ /path/to/new-project/
cd /path/to/new-project
./init-task-tracking.sh
```

**Option C: Shared Network Drive**
- Place on company network drive
- Share path with team
- Run from network location

## Updating

To update all projects with new task tracking features:

1. Update this repository
2. Re-run installer in each project:
   ```bash
   ./init-task-tracking.sh
   ```
3. Installer is idempotent (safe to run multiple times)

## Troubleshooting

### "Git user.name not configured"

```bash
git config --global user.name "Your Name"
```

### "CLAUDE.md not found"

Run `/init` command in Claude Code first, then re-run installer.

### "Task tracking section already exists"

Already installed! No action needed.

### Permission Denied

```bash
chmod +x init-task-tracking.sh
```

## Files in This Repository

```
task-tracking-system/
├── README.md                      # This file
├── TASK_TRACKING_TEMPLATE.md      # Task tracking documentation
├── init-task-tracking.sh          # Automated installer
└── templates/                     # README templates
    ├── task-README.md             # For task/ folder
    └── completed-README.md        # For completed_task/ folder
```

## Support

For issues or questions:
- Check documentation in `TASK_TRACKING_TEMPLATE.md`
- Review examples in `task/README.md`
- See workflow in your project's `CLAUDE.md`

## License

Internal company use. Modify as needed for your projects.

---

**Ready to install?** Run `./init-task-tracking.sh` in your project directory!
