/**
 * SVGO Configuration for The Collective Brand System
 * 
 * Optimizes SVG assets for web delivery while preserving
 * named groups needed for GSAP animation targeting.
 * 
 * Usage:
 *   npx svgo input.svg -o output.svg --config svgo.config.js
 *   npx svgo -f brand-assets/vector/individual/ --config svgo.config.js
 */

module.exports = {
  multipass: true,
  plugins: [
    // Remove metadata and comments
    'removeDoctype',
    'removeXMLProcInst',
    'removeComments',
    'removeMetadata',
    'removeEditorsNSData',
    'removeEmptyAttrs',
    'removeEmptyText',
    'removeEmptyContainers',
    'removeUnusedNS',

    // Clean up but preserve structure for animation
    'cleanupAttrs',
    'mergeStyles',
    'inlineStyles',
    'minifyStyles',
    'cleanupNumericValues',
    'convertColors',
    'removeNonInheritableGroupAttrs',
    'removeUselessStrokeAndFill',
    'removeHiddenElems',
    'removeUnknownsAndDefaults',

    // Keep viewBox (critical for responsive scaling)
    {
      name: 'removeViewBox',
      active: false,
    },

    // Remove width/height attrs so SVG scales via CSS
    {
      name: 'removeDimensions',
      active: true,
    },

    // Clean up IDs but keep them predictable
    {
      name: 'cleanupIDs',
      params: {
        prefix: 'tc-',    // "the-collective" prefix
        minify: false,     // Keep readable IDs for debugging
      },
    },

    // DO NOT collapse groups -- we need named groups
    // for targeting individual figures in GSAP animations
    {
      name: 'collapseGroups',
      active: false,
    },

    // Optimize paths but keep stroke detail
    {
      name: 'convertPathData',
      params: {
        floatPrecision: 2,
        transformPrecision: 3,
      },
    },

    // Merge paths only within same group
    {
      name: 'mergePaths',
      params: {
        force: false,
      },
    },

    // Sort attrs for consistency
    'sortAttrs',
    'sortDefsChildren',
  ],
};
