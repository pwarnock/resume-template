# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## AI-Assisted Resume Generation

This repo includes a Claude Code skill for generating tailored resumes from job postings.

### Quick Start

```bash
# 1. Save a job posting
mkdir jobs/company-name
# paste job description into jobs/company-name/job.md

# 2. Generate tailored resume (invoke skill)
"Generate a resume for @jobs/company-name"

# 3. Review the generated jobs/company-name/resume.md

# 4. Build PDF
./build/build.sh jobs/company-name/resume.md "Your-Name-Company"
```

### Skill Invocations

```
"Generate a resume for @jobs/company-name"              # Auto-select archetype
"Generate resume using platform-engineer archetype"    # Explicit archetype
"Which archetype fits @jobs/new-company best?"         # Analyze only
"Regenerate my default resume"                         # Update src/default.md
```

### Available Archetypes

| Archetype | Best For |
|-----------|----------|
| `product-engineer` | Product-focused, full-stack, startup roles |
| `platform-engineer` | DevOps, SRE, infrastructure, cloud architecture |
| `fractional-cto` | Leadership, strategy, advisory roles |
| `default` | Generic "share with anyone" version |

Add new archetypes in `.claude/skills/generate-resume/references/archetypes/`

## Build Commands

```bash
# Build from job application
./build/build.sh jobs/company-name/resume.md "Your-Name-Company"

# Build default resume
./build/build.sh src/default.md "Your-Name-Resume"

# Build base (all content)
./build/build.sh
```

**Requirements:** Pandoc and LaTeX (MacTeX on macOS, TeX Live on Linux)

## Architecture

**Key concept:** `src/base.md` is the single source of truth. The skill generates tailored versions by selecting and reframing content based on role archetypes.

**Directory structure:**
```
src/
  base.md           # Master resume (all content)
  default.md        # Generated "share with anyone" version

jobs/
  company-name/
    job.md          # Job posting
    resume.md       # Generated tailored resume

.claude/skills/generate-resume/
  SKILL.md          # Skill definition
  references/
    archetypes/     # Role archetype definitions
    tailoring.md    # Content guidelines
```

## Content Conventions

See `AGENTS.md` for detailed content style guidelines.

## Configuration

Environment variables in `.env`:
- `RESUME_OUTPUT_NAME` - Default output filename
- `RESUME_MARGIN` - Page margin (default: 1in)
