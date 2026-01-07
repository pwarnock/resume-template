# Resume Tailoring Guidelines

## Core Philosophy

**Authentic reframing, not deceptive rewriting.**

Every bullet point in the generated resume must be traceable to real content in `src/base.md`. The goal is to emphasize truth, not fabricate it.

## The Golden Rules

### 1. Never Invent Content

- Every skill listed must exist in base.md
- Every achievement must be real
- Every metric must be accurate
- If base.md doesn't have it, the generated resume can't have it

### 2. Never Remove Required Sections

All generated resumes must include:
- Header (name, tagline, contact info)
- Summary
- Technical Skills
- Professional Experience (all jobs, can trim bullets)
- Education & Certifications

### 3. Reframe, Don't Rewrite

**Good (reframing):**
- Original: "Led proactive cloud migration from Joyent to AWS"
- Product focus: "Led cloud modernization enabling faster product iteration"
- Platform focus: "Led proactive cloud migration from Joyent to AWS, adopting containers, Lambda, and modern cloud-native patterns"

**Bad (rewriting):**
- Changing "40+ engineers" to "50+ engineers"
- Adding technologies not actually used
- Inventing metrics

### 4. Target 1-2 Pages

- Select 3-5 bullets per job (not all of them)
- Remove redundant or less-relevant bullets
- Keep recent roles fuller, older roles briefer

## Tailoring Techniques

### Bullet Selection

Choose bullets that demonstrate skills the job requires:

| Job Requires | Select Bullets About |
|--------------|---------------------|
| React/TypeScript | Frontend projects, UI work |
| AWS/Infrastructure | Cloud migration, DevOps work |
| Leadership | Team building, mentorship |
| Startup experience | Early employee roles, founder work |
| Scale | Metrics with numbers (users, engineers, savings) |

### Bullet Ordering

Within each job, order bullets by relevance to target role:
1. Most relevant achievement first
2. Supporting achievements next
3. Less relevant (but still valuable) last

### Skill Ordering

Reorder skills within categories based on job requirements:

**For a React job:**
```
**Frontend:** React, Next.js, Tailwind CSS
```

**For a Python job:**
```
**Languages:** Python, TypeScript, JavaScript, Golang
```

### Summary Rewriting

The summary can be substantially rewritten (within truth bounds) to:
- Lead with what the role needs
- Emphasize relevant experience
- Set the right narrative frame

### Tagline Adjustment

The tagline (second line after name) should reflect the archetype:
- Product: "Product Engineer | Full-Stack Builder | AI-Augmented Development"
- Platform: "Platform Engineer | Cloud Architecture | Developer Experience"
- Leadership: "Engineering Leader | Technical Strategy | Startup Advisor"

## Keyword Mirroring

When the job posting uses specific terminology, mirror it authentically:

| Job Says | Resume Can Say |
|----------|----------------|
| "Product-minded engineer" | "Product-minded engineer" (if true) |
| "SRE" | "SRE" or "Site Reliability" (if did this work) |
| "AI-first" | Reference AI projects prominently |

**Don't force keywords that don't fit authentically.**

## What to Never Do

1. **Don't add fake skills** - If you didn't use Kubernetes, don't add it
2. **Don't inflate metrics** - "40+ engineers" doesn't become "50+"
3. **Don't change job titles** - Keep actual titles from base.md
4. **Don't add fake companies** - Obviously
5. **Don't claim certifications you don't have**
6. **Don't backdate AI experience** - Recent AI work is recent

## Output Format

Generated resumes must maintain exact formatting from base.md:

### Header Format
```markdown
# Your Name
**Tagline | From | Archetype**
City, State | Phone | Email | LinkedIn | GitHub
```

### Section Headers
```markdown
## Summary
## Recent Projects
## Technical Skills
## Professional Experience
## Education & Certifications
```

### Job Entry Format
```markdown
### Job Title
**Company Name** | Location | Start Date – End Date

Brief context about the role or company (1 line).

- Achievement bullet
- Achievement bullet
- Achievement bullet
```

### Skills Format
```markdown
**Category:** Item, Item, Item
```

### Project Table
```markdown
| Project | Description | Stack |
|---------|-------------|-------|
| **name** | Description | Tech, Stack |
```

## Quality Checklist

Before finalizing a generated resume:

- [ ] Every bullet traceable to base.md content
- [ ] All required sections present
- [ ] Tagline matches archetype
- [ ] Summary emphasizes right themes
- [ ] Skills ordered by relevance
- [ ] 3-5 bullets per job
- [ ] Total length targets 1-2 pages
- [ ] Formatting matches base.md conventions
- [ ] No invented content
- [ ] Frontmatter includes generation metadata
