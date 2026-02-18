#!/bin/bash
# =============================================================================
# SVG Optimisation Script
# The Collective Brand Illustration System
# =============================================================================
# Usage: ./scripts/optimise.sh
# Requires: npx (Node.js), svgo
# =============================================================================

set -euo pipefail

# Paths
RAW_DIR="brand-assets/svg/raw"
OPT_DIR="brand-assets/svg/optimised"
CONFIG="svgo.config.js"

# Colours for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

echo -e "${YELLOW}=== SVG Optimisation Pipeline ===${NC}"
echo ""

# Check prerequisites
if ! command -v npx &> /dev/null; then
  echo -e "${RED}Error: npx not found. Install Node.js first.${NC}"
  exit 1
fi

# Check source directory
if [ ! -d "$RAW_DIR" ]; then
  echo -e "${RED}Error: Raw SVG directory not found at $RAW_DIR${NC}"
  exit 1
fi

# Check config exists
if [ ! -f "$CONFIG" ]; then
  echo -e "${RED}Error: SVGO config not found at $CONFIG${NC}"
  exit 1
fi

# Create output directory if needed
mkdir -p "$OPT_DIR"

# Count SVG files
SVG_COUNT=$(find "$RAW_DIR" -name "*.svg" -type f | wc -l | tr -d ' ')

if [ "$SVG_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No SVG files found in $RAW_DIR${NC}"
  echo "Add raw SVG exports to $RAW_DIR and run again."
  exit 0
fi

echo -e "Found ${GREEN}$SVG_COUNT${NC} SVG file(s) in $RAW_DIR"
echo ""

# Track totals
TOTAL_BEFORE=0
TOTAL_AFTER=0
PROCESSED=0

# Process each SVG
for svg in "$RAW_DIR"/*.svg; do
  FILENAME=$(basename "$svg")
  BEFORE_SIZE=$(wc -c < "$svg" | tr -d ' ')
  
  # Run SVGO
  npx svgo --config "$CONFIG" -i "$svg" -o "$OPT_DIR/$FILENAME" 2>/dev/null
  
  AFTER_SIZE=$(wc -c < "$OPT_DIR/$FILENAME" | tr -d ' ')
  
  # Calculate savings
  if [ "$BEFORE_SIZE" -gt 0 ]; then
    SAVINGS=$(( (BEFORE_SIZE - AFTER_SIZE) * 100 / BEFORE_SIZE ))
  else
    SAVINGS=0
  fi
  
  TOTAL_BEFORE=$((TOTAL_BEFORE + BEFORE_SIZE))
  TOTAL_AFTER=$((TOTAL_AFTER + AFTER_SIZE))
  PROCESSED=$((PROCESSED + 1))
  
  echo -e "  ${GREEN}OK${NC} $FILENAME: ${BEFORE_SIZE}B -> ${AFTER_SIZE}B (${SAVINGS}% saved)"
done

echo ""
echo -e "${GREEN}=== Optimisation Complete ===${NC}"
echo -e "Files processed: $PROCESSED"

if [ "$TOTAL_BEFORE" -gt 0 ]; then
  TOTAL_SAVINGS=$(( (TOTAL_BEFORE - TOTAL_AFTER) * 100 / TOTAL_BEFORE ))
  echo -e "Total before:   ${TOTAL_BEFORE}B"
  echo -e "Total after:    ${TOTAL_AFTER}B"
  echo -e "Total saved:    ${GREEN}${TOTAL_SAVINGS}%${NC}"
fi

echo ""
echo -e "Optimised files written to ${GREEN}$OPT_DIR/${NC}"
