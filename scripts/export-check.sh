#!/bin/bash
# =============================================================================
# SVG Export Quality Check
# The Collective Brand Illustration System
# =============================================================================
# Usage: ./scripts/export-check.sh [optional: path/to/svg]
# Validates SVG files against project conventions before optimisation.
# =============================================================================

set -euo pipefail

# Colours
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Defaults
CHECK_DIR="${1:-brand-assets/svg/raw}"
MAX_SIZE_KB=200
ERRORS=0
WARNINGS=0
PASSED=0

echo -e "${YELLOW}=== SVG Export Quality Check ===${NC}"
echo -e "Checking: $CHECK_DIR"
echo ""

# Check directory exists
if [ ! -d "$CHECK_DIR" ]; then
  echo -e "${RED}Error: Directory not found: $CHECK_DIR${NC}"
  exit 1
fi

# Count files
SVG_COUNT=$(find "$CHECK_DIR" -name "*.svg" -type f | wc -l | tr -d ' ')

if [ "$SVG_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No SVG files found in $CHECK_DIR${NC}"
  exit 0
fi

echo -e "Found $SVG_COUNT SVG file(s)"
echo ""

for svg in "$CHECK_DIR"/*.svg; do
  FILENAME=$(basename "$svg")
  FILE_ERRORS=0
  
  echo -e "Checking: ${FILENAME}"
  
  # --- Check 1: File size ---
  FILE_SIZE=$(wc -c < "$svg" | tr -d ' ')
  FILE_SIZE_KB=$((FILE_SIZE / 1024))
  
  if [ "$FILE_SIZE_KB" -gt "$MAX_SIZE_KB" ]; then
    echo -e "  ${RED}FAIL${NC} File size: ${FILE_SIZE_KB}KB (max: ${MAX_SIZE_KB}KB)"
    FILE_ERRORS=$((FILE_ERRORS + 1))
  else
    echo -e "  ${GREEN}PASS${NC} File size: ${FILE_SIZE_KB}KB"
  fi
  
  # --- Check 2: Has viewBox ---
  if grep -q 'viewBox' "$svg"; then
    echo -e "  ${GREEN}PASS${NC} viewBox attribute present"
  else
    echo -e "  ${RED}FAIL${NC} Missing viewBox attribute"
    FILE_ERRORS=$((FILE_ERRORS + 1))
  fi
  
  # --- Check 3: No embedded raster images ---
  if grep -qi '<image' "$svg"; then
    echo -e "  ${RED}FAIL${NC} Contains embedded raster image (<image> tag)"
    FILE_ERRORS=$((FILE_ERRORS + 1))
  else
    echo -e "  ${GREEN}PASS${NC} No embedded raster images"
  fi
  
  # --- Check 4: No inline styles (prefer classes) ---
  STYLE_COUNT=$(grep -c 'style="' "$svg" || true)
  if [ "$STYLE_COUNT" -gt 5 ]; then
    echo -e "  ${YELLOW}WARN${NC} Found $STYLE_COUNT inline styles (prefer CSS classes)"
    WARNINGS=$((WARNINGS + 1))
  else
    echo -e "  ${GREEN}PASS${NC} Inline styles: $STYLE_COUNT (acceptable)"
  fi
  
  # --- Check 5: Has meaningful layer/group IDs ---
  ID_COUNT=$(grep -co 'id="[a-z]' "$svg" || true)
  if [ "$ID_COUNT" -eq 0 ]; then
    echo -e "  ${YELLOW}WARN${NC} No semantic IDs found (needed for GSAP targeting)"
    WARNINGS=$((WARNINGS + 1))
  else
    echo -e "  ${GREEN}PASS${NC} Found $ID_COUNT semantic ID(s)"
  fi
  
  # --- Check 6: No JavaScript ---
  if grep -qi '<script' "$svg"; then
    echo -e "  ${RED}FAIL${NC} Contains embedded JavaScript"
    FILE_ERRORS=$((FILE_ERRORS + 1))
  else
    echo -e "  ${GREEN}PASS${NC} No embedded scripts"
  fi
  
  # --- Check 7: UTF-8 encoding ---
  if file "$svg" | grep -qi 'utf-8\|ascii\|text'; then
    echo -e "  ${GREEN}PASS${NC} Valid text encoding"
  else
    echo -e "  ${YELLOW}WARN${NC} Unexpected file encoding"
    WARNINGS=$((WARNINGS + 1))
  fi
  
  if [ "$FILE_ERRORS" -gt 0 ]; then
    ERRORS=$((ERRORS + FILE_ERRORS))
  else
    PASSED=$((PASSED + 1))
  fi
  
  echo ""
done

# Summary
echo -e "${YELLOW}=== Summary ===${NC}"
echo -e "Files checked: $SVG_COUNT"
echo -e "Passed:        ${GREEN}$PASSED${NC}"
echo -e "Errors:        ${RED}$ERRORS${NC}"
echo -e "Warnings:      ${YELLOW}$WARNINGS${NC}"

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo -e "${RED}Some checks failed. Fix issues before running optimise.sh${NC}"
  exit 1
else
  echo ""
  echo -e "${GREEN}All checks passed. Ready for optimisation.${NC}"
  exit 0
fi
