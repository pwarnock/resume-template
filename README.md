# Resume Template

A structured resume management system with version control and PDF generation.

## Features

- **Markdown-based** — Write your resume in plain text
- **Version control** — Track changes with git
- **Role variations** — Maintain tailored versions for different job types
- **Job reference library** — Store job descriptions for context when tailoring
- **Clean PDFs** — Generates professional PDFs with no word hyphenation

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- LaTeX distribution ([MacTeX](https://www.tug.org/mactex/) on macOS, [TeX Live](https://www.tug.org/texlive/) on Linux)

## Quick Start

```bash
# Create your resume project
bun create pwarnock/resume-template my-resume
cd my-resume

# Copy the example to start your base resume
cp src/example.md src/base.md

# Edit your resume
# ... edit src/base.md ...

# Build PDF
./build/build.sh
# Output: output/Resume.pdf
```

## Project Structure

```
my-resume/
├── src/                    # Your resume markdown files
│   ├── base.md             # Master resume (all your content)
│   ├── frontend-dev.md     # Role-specific variation
│   └── backend-dev.md      # Another variation
├── jobs/                   # Job descriptions for reference
│   └── company-role.md
├── output/                 # Generated PDFs (gitignored)
├── build/
│   ├── build.sh            # PDF generation script
│   └── preamble.tex        # LaTeX settings
└── README.md
```

## Workflow

### Initial Setup

1. Copy `src/example.md` to `src/base.md`
2. Fill in your complete work history, all projects, all skills
3. This is your master resume — it contains everything

### Applying to Jobs

1. Save job description to `jobs/company-role.md` for reference
2. Create a variation: `cp src/base.md src/role-name.md`
3. Tailor the variation for the specific role
4. Build: `./build/build.sh src/role-name.md "Your-Name-Role"`
5. Commit your changes

### Build Commands

```bash
# Build default (src/base.md → output/Resume.pdf)
./build/build.sh

# Build specific file with custom output name
./build/build.sh src/frontend-dev.md "Jane-Doe-Frontend"
```

## Why This Structure?

- **base.md as single source of truth** — Never lose content; variations are subsets
- **Job descriptions saved** — Remember context when updating variations later
- **Git tracks iterations** — No need for dated file copies
- **PDFs gitignored** — They're generated artifacts, regenerate anytime

## Technical Details

The build script uses Pandoc with pdflatex and custom LaTeX settings that:
- Disable word hyphenation (no "develop-\nment" breaks)
- Set consistent 1-inch margins
- Use microtype for better text rendering

## License

MIT
