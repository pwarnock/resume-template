#!/bin/bash

# Build resume PDF with hyphenation disabled
# Uses Pandoc with MacTeX to convert markdown to PDF
#
# Usage: ./build/build.sh [source.md] [output-name]
#   source.md   - Path to markdown file (default: src/base.md)
#   output-name - Output filename without extension (default: Resume)

set -e

# Get project root (parent of build directory)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
SOURCE="${1:-src/base.md}"
OUTPUT_NAME="${2:-Resume}"

# Build paths
SOURCE_PATH="$PROJECT_ROOT/$SOURCE"
OUTPUT_PATH="$PROJECT_ROOT/output/$OUTPUT_NAME.pdf"
PREAMBLE_PATH="$SCRIPT_DIR/preamble.tex"

# Validate source exists
if [ ! -f "$SOURCE_PATH" ]; then
    echo "Error: Source file not found: $SOURCE_PATH"
    exit 1
fi

# Generate PDF
pandoc "$SOURCE_PATH" \
  -o "$OUTPUT_PATH" \
  -V geometry:margin=1in \
  --include-in-header="$PREAMBLE_PATH" \
  --pdf-engine=pdflatex

echo "✓ Generated $OUTPUT_PATH"
