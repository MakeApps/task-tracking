#!/bin/bash

#######################################
# Task Tracking System Installer
# Automates the setup of folder-based task tracking
#######################################

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Initializing Task Tracking System...${NC}\n"

# Step 1: Create task directories
echo -e "${GREEN}→${NC} Creating task/ directory structure..."
mkdir -p task/completed_task
echo -e "${GREEN}✓${NC} Created task/ and task/completed_task/ directories"

# Step 2: Create task/README.md
echo -e "${GREEN}→${NC} Creating task/README.md..."
cat > task/README.md << 'EOF'
# Active Tasks

This folder contains documentation for all currently active/in-progress tasks.

## Purpose

Each task file tracks:
- What is being worked on
- Files being modified
- Changes made with timestamps
- Testing notes
- Issues encountered

## Task File Naming

**Format**: `task-<username>-<number>-<brief-description>.md`

The username comes FIRST to automatically group tasks by developer when sorted alphabetically.

**Username Auto-Detection**: The username is automatically extracted from your local git configuration using `git config user.name` (or `user.email` as fallback). No manual input required!

### Examples:

**Human Developers:**
- `task-johndoe-001-add-user-authentication.md`
- `task-johndoe-002-implement-profile-editing.md`
- `task-sarasmith-001-fix-listing-search-bug.md`
- `task-mprabhat-001-refactor-api-client.md`

**AI Assistant:**
- `task-claude-001-add-pagination-component.md`
- `task-claude-002-optimize-database-queries.md`

### Benefits:
- Files automatically group by developer when sorted
- Easy filtering: `ls task-johndoe-*` shows all tasks for that developer
- Each developer maintains their own numbering sequence
- No number conflicts between developers

## Workflow

1. Say "new task" - Claude will automatically detect your username from git config
2. Provide task name and description
3. Claude creates git branch: `git checkout -b task/<username>-<number>-description`
4. Claude creates task file in this folder using the template from CLAUDE.md
5. Work on the task, updating the file regularly
6. When complete, task file is moved to `task/completed_task/` subfolder

See `CLAUDE.md` for complete workflow documentation.
EOF
echo -e "${GREEN}✓${NC} Created task/README.md"

# Step 3: Create task/completed_task/README.md
echo -e "${GREEN}→${NC} Creating task/completed_task/README.md..."
cat > task/completed_task/README.md << 'EOF'
# Completed Tasks

This folder contains documentation for all completed and archived tasks.

## Purpose

This serves as a historical record of:
- Features developed
- Bugs fixed
- Refactoring work done
- Who worked on what (human or AI)
- How changes were implemented

## File Organization

Files use the format: `task-<username>-<number>-<description>.md`

This automatically groups completed tasks by developer when sorted alphabetically, making it easy to:
- View all tasks completed by a specific developer
- Track each developer's contribution history
- Find task-specific documentation quickly

**Example sorting:**
```
task-claude-001-implement-dark-mode.md
task-claude-002-add-pagination.md
task-johndoe-001-add-authentication.md
task-johndoe-002-profile-editing.md
task-sarasmith-001-fix-search-bug.md
```

## Task History

Completed tasks are moved here from the `task/` folder after:
1. Implementation is complete and pushed to task branch
2. Developer reviews and tests the changes
3. Developer approves completion ("completed" or "mark complete")

## Using This Archive

- Reference past solutions when working on similar features
- Understand why certain architectural decisions were made
- Find rollback instructions if a feature needs to be reverted
- Track project evolution over time
- Filter by developer: `ls task-johndoe-*` to see all of johndoe's completed tasks

## Maintenance

- Files should NOT be deleted from this folder
- Keep this folder committed to git for team history
- Use git log on these files to see when tasks were completed
- Each developer's task numbering remains sequential within their namespace
EOF
echo -e "${GREEN}✓${NC} Created task/completed_task/README.md"

# Step 4: Add task/ folder to git
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${GREEN}→${NC} Adding task/ folder to git..."
    git add task/
    echo -e "${GREEN}✓${NC} Added task/ folder to git staging area"
else
    echo -e "${YELLOW}⚠${NC}  Not a git repository - skipping git add"
fi

# Step 5: Check if CLAUDE.md exists
echo ""
if [ -f "CLAUDE.md" ]; then
    echo -e "${GREEN}→${NC} Found existing CLAUDE.md"

    # Check if task tracking section already exists
    if grep -q "## Task Tracking Workflow" CLAUDE.md; then
        echo -e "${YELLOW}⚠${NC}  Task Tracking Workflow section already exists in CLAUDE.md"
        echo -e "${YELLOW}⚠${NC}  Skipping append (already installed)"
    else
        echo -e "${GREEN}→${NC} Appending Task Tracking Workflow section to CLAUDE.md..."

        # Add a newline before appending (if file doesn't end with newline)
        [ -n "$(tail -c1 CLAUDE.md)" ] && echo "" >> CLAUDE.md

        # Append the task tracking template
        if [ -f "$SCRIPT_DIR/TASK_TRACKING_TEMPLATE.md" ]; then
            cat "$SCRIPT_DIR/TASK_TRACKING_TEMPLATE.md" >> CLAUDE.md
            echo -e "${GREEN}✓${NC} Appended Task Tracking Workflow section to CLAUDE.md"
        else
            echo -e "${RED}✗${NC} TASK_TRACKING_TEMPLATE.md not found in script directory"
            echo -e "${YELLOW}→${NC} Please manually copy the task tracking section to CLAUDE.md"
        fi
    fi
else
    echo -e "${YELLOW}⚠️  CLAUDE.md not found in this project.${NC}\n"
    echo -e "${BLUE}To complete the setup:${NC}"
    echo -e "  1. In Claude Code, run the ${GREEN}init${NC} slash command to analyze this project"
    echo -e "  2. This will create CLAUDE.md with project-specific documentation"
    echo -e "  3. Then run this script again: ${GREEN}./init-task-tracking.sh${NC}"
    echo -e "  4. Task tracking section will be appended to CLAUDE.md\n"
    echo -e "${BLUE}📝 Partial installation complete (task folders created).${NC}"
    echo -e "${BLUE}   Re-run after creating CLAUDE.md to finish setup.${NC}"
    exit 0
fi

# Step 6: Final success message
echo ""
echo -e "${GREEN}✅ Task tracking system installed successfully!${NC}\n"
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Review CLAUDE.md for the new Task Tracking Workflow section"
echo -e "  2. Commit the changes: ${GREEN}git commit -m \"Add task tracking system\"${NC}"
echo -e "  3. Start using: Just say ${GREEN}\"new task\"${NC} to Claude Code!\n"
