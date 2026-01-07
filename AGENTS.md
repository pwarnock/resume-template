# AGENTS.md - Resume Template Project

This is a markdown-based resume management system that generates professional PDFs using Pandoc and LaTeX. The system includes AI-assisted resume generation via Claude Code skills.

## AI-Assisted Resume Generation

### The generate-resume Skill

Located in `.claude/skills/generate-resume/`, this skill automates resume tailoring:

```
"Generate a resume for @jobs/company-name"    # Auto-select archetype
"Generate resume using platform-engineer"     # Explicit archetype
"Which archetype fits this job best?"         # Analyze only
"Regenerate my default resume"                # Update src/default.md
```

### Archetypes

Role archetypes define how to tailor `src/base.md` for different role types:

| Archetype | Location | Best For |
|-----------|----------|----------|
| `product-engineer` | `references/archetypes/product-engineer.md` | Product-focused, startup roles |
| `platform-engineer` | `references/archetypes/platform-engineer.md` | DevOps, SRE, infrastructure |
| `fractional-cto` | `references/archetypes/fractional-cto.md` | Leadership, advisory roles |
| `default` | `references/archetypes/default.md` | Generic "share with anyone" |

Each archetype defines: tagline, trigger keywords, summary focus, skills priority, experience emphasis, and de-emphasis areas.

### Generation Workflow

1. Skill reads job posting from `jobs/{company}/job.md`
2. Analyzes requirements and selects best archetype
3. Loads archetype guidance from `references/archetypes/`
4. Generates tailored resume following `references/tailoring.md`
5. Outputs to `jobs/{company}/resume.md`

### Adding New Archetypes

Create a new file in `.claude/skills/generate-resume/references/archetypes/` with YAML frontmatter defining the archetype configuration and markdown body with detailed guidance.

## Build Commands

### Generate PDF
```bash
# Build default resume (src/base.md -> output/Resume.pdf)
./build/build.sh

# Build specific variation with custom output name
./build/build.sh src/frontend-dev.md "Your-Name-Frontend"

# Build with full path
./build/build.sh src/backend-dev.md "Jane-Doe-Backend"
```

### Build Script Details
The build script (`build/build.sh`) validates source files and generates PDFs using:
- Pandoc for markdown-to-PDF conversion
- pdflatex as the PDF engine
- Custom LaTeX preamble (`build/preamble.tex`) for professional formatting

Output directory: `output/` (gitignored, regenerated on each build)

### Customizing Output Name
Set `RESUME_OUTPUT_NAME` in `.env` (copy from `.env.example`):
```bash
cp .env.example .env
# Edit .env to set RESUME_OUTPUT_NAME=Your-Name-Role
source .env && ./build/build.sh
```

Or override via CLI argument:
```bash
./build/build.sh src/base.md "Custom-Output-Name"
```

### Page Margin
Configure `RESUME_MARGIN` in `.env` (LaTeX syntax):
```bash
RESUME_MARGIN=1in   # default
RESUME_MARGIN=0.75in  # tighter
RESUME_MARGIN=1.25in  # more generous
```

## Workflow

### Apply to a New Job (AI-Assisted)

1. **Save the job description:**
   ```bash
   mkdir jobs/company-name
   # Paste job description into jobs/company-name/job.md
   ```

2. **Generate tailored resume:**
   ```
   "Generate a resume for @jobs/company-name"
   ```
   The skill will analyze the job, select an archetype, and create `jobs/company-name/resume.md`

3. **Review and tweak** the generated resume as needed

4. **Build the PDF:**
   ```bash
   ./build/build.sh jobs/company-name/resume.md "Your-Name-Company"
   ```

5. **Commit your changes:**
   ```bash
   git add jobs/company-name/
   git commit -m "Apply to Company X"
   ```

### Apply to a New Job (Manual)

1. **Save the job description:**
   ```bash
   mkdir jobs/company-name
   cp jobs/example/job.md jobs/company-name/job.md
   # Edit with job URL, requirements, compensation, and your notes
   ```

2. **Create a tailored variation:**
   ```bash
   cp src/base.md jobs/company-name/resume.md
   # Edit to highlight relevant experience for this role
   ```

3. **Build the PDF:**
   ```bash
   ./build/build.sh jobs/company-name/resume.md "Your-Name-Company"
   ```

### Update Your Master Resume

```bash
vim src/base.md
# Add new jobs, projects, skills, achievements
# This is your single source of truth
```

### Quick PDF of Base Resume

```bash
source .env && ./build/build.sh
```

### Project Structure

```
resume/
├── .claude/skills/generate-resume/   # <- AI resume generation skill
│   ├── SKILL.md
│   └── references/
│       ├── archetypes/               # <- Role archetype definitions
│       └── tailoring.md
├── src/
│   ├── base.md                       # <- Master resume (single source of truth)
│   └── default.md                    # <- Generated "share with anyone" version
├── jobs/
│   └── company-name/
│       ├── job.md                    # <- Job posting
│       └── resume.md                 # <- Generated/tailored resume
├── output/                           # <- Generated PDFs (gitignored)
├── .env                              # <- Your personalized defaults
└── AGENTS.md                         # <- This documentation
```

### Key Principle

`src/base.md` is your single source of truth. Variations are subsets—re-create them anytime from base + job description notes. Never delete content from base; only remove from variations.

## Content Style Guidelines

### Markdown Structure
All resume markdown files follow this header format:
```markdown
# Your Name
**Your Title | Your Specialty | Your Focus**
City, State | (555) 555-5555 | you@email.com | linkedin.com/in/you | github.com/you
```

Sections in order: Summary -> Recent Projects -> Technical Skills -> Professional Experience -> Education & Certifications

### Bullet Point Conventions
- Start with action verbs in past tense for previous roles, present tense for current role
- Include quantifiable impact where possible (metrics, percentages, outcomes)
- Focus on achievements, not just responsibilities
- One bullet per line, no trailing periods unless listing multiple items

### Technical Skills Formatting
Use bold labels with colon separators:
```markdown
**Languages:** TypeScript, Python, Go
**Frontend:** React, Next.js, Tailwind
**Backend:** Node.js, PostgreSQL, Redis
```

### Project Table Format
Use pipe tables with Project, Description, Stack columns:
```markdown
| Project | Description | Stack |
|---------|-------------|-------|
| **project-name** | Brief description | React, Node.js |
```

### LaTeX/Print Considerations
The preamble (`build/preamble.tex`) disables hyphenation for clean breaks. Content should be concise enough to fit standard resume length (1-2 pages). Avoid overly long paragraphs.

## Project Conventions

### File Naming
- `src/base.md` - Master resume containing all content
- `src/default.md` - Generated "share with anyone" version
- `jobs/[company]/job.md` - Job postings
- `jobs/[company]/resume.md` - Generated/tailored resumes
- `.claude/skills/generate-resume/references/archetypes/[name].md` - Role archetypes

### Git Workflow
- Commit variations when tailoring for specific applications
- Job descriptions in `jobs/` help remember context when updating variations later
- PDFs are gitignored (regenerate anytime from source)

### No Linting/Tests
This project has no test suite or linting. Quality checks are manual:
- Proofread for typos
- Verify PDF output formatting
- Check for consistent formatting across resume variations

## Cursor/Copilot Rules
None configured. Follow the conventions in this file and the README.md.

## Quick Reference

### AI-Assisted Commands
| Invocation | Purpose |
|------------|---------|
| `"Generate resume for @jobs/company"` | Generate tailored resume |
| `"Which archetype fits @jobs/company?"` | Analyze job posting |
| `"Regenerate my default resume"` | Update src/default.md |

### Build Commands
| Command | Purpose |
|---------|---------|
| `./build/build.sh` | Build src/base.md -> output/Resume.pdf |
| `./build/build.sh jobs/co/resume.md "Name-Co"` | Build job application |
| `mkdir jobs/company && vim jobs/company/job.md` | Create new job folder |

## Content Examples

### Summary Section (2-3 sentences)
Concise professional summary highlighting your unique value. Mention:
- Years of experience
- Key expertise areas
- Notable impact or achievements
- What you're seeking next

Example:
```markdown
## Summary
Full-stack engineer with 7+ years building scalable web applications. Led platform migrations serving 10M+ users, reducing infrastructure costs by 40%. Passionate about developer experience and mentorship. Seeking senior engineering roles at mission-driven companies.
```

### Professional Experience Format
Each role should have:
- Job title (### heading)
- Company with location and dates (**bold** inline)
- 1-line context about company/role
- 3-5 achievement-focused bullets

Example:
```markdown
### Senior Software Engineer
**TechCorp** | San Francisco, CA | Jan 2022 – Present

Series B fintech startup serving 500K+ users.

- Architected and shipped new payment processing system, handling $2M+ monthly transactions
- Reduced query latency by 60% through database optimization and caching strategy
- Mentored 4 junior engineers to promotion-readiness within 12 months
```

### Recent Projects Section
Showcase 2-3 key projects with:
- Project name (bold)
- 1-sentence description
- Tech stack (comma-separated)

Example:
```markdown
## Recent Projects
| Project | Description | Stack |
|---------|-------------|-------|
| **resume-template** | Markdown-based resume system with PDF generation | Pandoc, LaTeX, Bash |
| **api-gateway** | Microservices gateway with rate limiting and auth | Go, Redis, Kubernetes |
```
