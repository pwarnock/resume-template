---
name: generate-resume
description: Generate tailored resumes from job postings by analyzing role requirements and selecting the best archetype. Use when you have a job description and need a tailored resume, when applying to a new job, or when someone asks which resume variation fits a role. Triggers on requests mentioning job postings, resume tailoring, archetypes, or generating application materials.
---

# Generate Tailored Resume

Generate job-targeted resumes by analyzing postings and applying role archetypes to the master resume content.

## Quick Start

```
"Generate a resume for @jobs/company-name"
"Which archetype fits this job posting best?"
"Regenerate my default resume"
```

## Workflow

### Step 1: Analyze Job Posting

Read the job posting from `jobs/{company}/job.md` and extract:
- Role title and seniority level
- Required technical skills
- Nice-to-have qualifications
- Company stage (startup, growth, enterprise)
- Culture signals (remote, async, product-focused, etc.)
- Key themes and keywords

### Step 2: Select Archetype

Load archetypes from `references/archetypes/` and score each against the job requirements.

**Available archetypes:**
| Archetype | Best For |
|-----------|----------|
| `product-engineer` | Product-focused roles, full-stack, startup, user-facing features |
| `platform-engineer` | Infrastructure, DevOps, SRE, internal tools, cloud architecture |
| `fractional-cto` | Leadership, strategy, architecture, mentorship, advisory |
| `default` | Generic "share with anyone" version, balanced emphasis |

**Selection logic:**
1. Count keyword matches from archetype's `trigger_keywords`
2. Score alignment between job requirements and archetype's `experience_emphasis`
3. Select highest-scoring archetype
4. If scores are within 15%, ask user to choose

Load the selected archetype: `references/archetypes/{archetype-name}.md`

### Step 3: Generate Resume

Using guidance from `references/tailoring.md` and the selected archetype:

1. **Read master content** from `src/base.md`
2. **Apply tagline** from archetype
3. **Rewrite summary** emphasizing archetype's `summary_focus` themes
4. **Reorder skills** based on `skills_priority` (most relevant first)
5. **Select experience bullets** that demonstrate required skills
6. **Reframe bullets** to emphasize relevant aspects (not rewrite entirely)
7. **Reorder projects** based on relevance to role

### Step 4: Output

Write the generated resume to `jobs/{company}/resume.md` with frontmatter:

```yaml
---
generated_at: [ISO timestamp]
source: src/base.md
archetype: [selected archetype]
job_posting: jobs/{company}/job.md
---
```

Report to user:
- Selected archetype and confidence score
- Key tailoring decisions made
- Suggested next steps: review, build PDF

## Critical Rules

1. **Never invent content** — Only use content from `src/base.md`
2. **Never remove sections** — Summary, Skills, Experience, Education must all appear
3. **Reframe, don't rewrite** — Emphasize different aspects of the same achievements
4. **Maintain formatting** — Follow exact markdown conventions from base.md
5. **Target 1-2 pages** — Be selective with bullets; quality over quantity

## Invocation Patterns

```bash
# Generate for specific job application
"Generate a resume for @jobs/company-name"

# With explicit archetype (skip auto-selection)
"Generate a resume for @jobs/stripe using the platform-engineer archetype"

# Regenerate the default "share with anyone" version
"Regenerate my default resume"
"Update src/default.md with product-engineer focus"

# Analyze only (recommend archetype without generating)
"Which archetype fits @jobs/new-company best?"
"Analyze this job posting for archetype fit"

# Create new archetype
"Create a new archetype for frontend-engineer roles"
```

## Directory Structure

```
jobs/
  {company}/
    job.md          # Job posting (input)
    resume.md       # Generated resume (output)

src/
  base.md           # Master resume (source of truth)
  default.md        # Generic "share with anyone" version

.claude/skills/generate-resume/
  SKILL.md          # This file
  references/
    archetypes/     # Role archetype definitions
    tailoring.md    # Content tailoring guidelines
```

## Building PDF

After generating and reviewing the resume:

```bash
./build/build.sh jobs/{company}/resume.md "Your-Name-Company"
```

Output: `output/Your-Name-Company.pdf`

## Adding New Archetypes

Create a new file in `references/archetypes/` following the format:

```markdown
---
name: archetype-name
tagline: "Your Title | Specialty | Focus"
trigger_keywords:
  - keyword1
  - keyword2
summary_focus:
  - theme1
  - theme2
skills_priority:
  - Skill1
  - Skill2
experience_emphasis:
  - emphasis1
  - emphasis2
de_emphasize:
  - thing1
  - thing2
---

# Archetype Name

## When to Use
Description of when this archetype applies...

## Key Themes
What to highlight...

## Experience Reframing
How to reframe specific roles...
```

## References

- [Archetype definitions](references/archetypes/) — Role-specific guidance
- [Tailoring guidelines](references/tailoring.md) — General tailoring principles
