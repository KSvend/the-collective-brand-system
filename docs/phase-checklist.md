# Phase Checklist - The Collective Brand Illustration System

## Phase 1: Foundation (Weeks 1-2)

### Illustration Brief
- [ ] Finalise visual style direction with illustrator
- [ ] Confirm colour palette mapping to CSS custom properties
- [ ] Define illustration categories (hero, spot, icon, decorative)
- [ ] Approve initial concept sketches
- [ ] Set artboard sizes and export specifications

### Repository Setup
- [x] Create repository structure
- [x] Add README with project overview
- [x] Configure SVGO optimisation pipeline
- [x] Set up GSAP animation scaffold
- [x] Add CSS custom properties / theme file
- [ ] Configure branch protection rules
- [ ] Set up GitHub Projects board for tracking

### SVG Architecture
- [ ] Define SVG naming conventions
- [ ] Create layer-naming guide for illustrator
- [ ] Document class-naming strategy for animation targets
- [ ] Test SVGO config with sample SVGs
- [ ] Validate SVG accessibility approach (titles, desc, aria)

---

## Phase 2: Asset Production (Weeks 3-5)

### Illustration Delivery
- [ ] Receive first batch of raw SVG illustrations
- [ ] QA check: layer names, class names, viewBox consistency
- [ ] Run SVGO optimisation on raw exports
- [ ] Compare raw vs optimised file sizes
- [ ] Store raw in `brand-assets/svg/raw/`
- [ ] Store optimised in `brand-assets/svg/optimised/`

### Component Preparation
- [ ] Break complex illustrations into reusable SVG components
- [ ] Add CSS custom property hooks to each SVG
- [ ] Test colour-theme switching (light/dark mode)
- [ ] Create symbol/sprite sheets if needed
- [ ] Document each component in animation-specs.md

### Colour & Typography
- [ ] Export colour palette swatches
- [ ] Map brand colours to CSS variables
- [ ] Confirm typography pairings for illustration labels
- [ ] Test contrast ratios for accessibility (WCAG AA)

---

## Phase 3: Animation & Integration (Weeks 5-7)

### GSAP Animation
- [ ] Implement scroll-triggered reveal animations
- [ ] Build hover micro-interactions for spot illustrations
- [ ] Create page-transition animation sequences
- [ ] Add loading/skeleton states for illustration zones
- [ ] Performance test: ensure < 16ms frame budgets
- [ ] Test with `prefers-reduced-motion` media query

### Lottie Animations
- [ ] Export hero animations as Lottie JSON
- [ ] Test Lottie playback in Webflow embed
- [ ] Optimise Lottie file sizes (target < 50KB each)
- [ ] Add fallback static SVGs for no-JS environments

### Webflow Integration
- [ ] Paste GSAP init script into Webflow custom code (before </body>)
- [ ] Paste theme.css into Webflow custom code (before </head>)
- [ ] Add SVG embed blocks to CMS template pages
- [ ] Test responsive behaviour across breakpoints
- [ ] Verify Webflow interactions don't conflict with GSAP

---

## Phase 4: QA & Polish (Weeks 7-8)

### Cross-Browser Testing
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest + iOS)
- [ ] Edge (latest)
- [ ] Test on actual mobile devices (iOS Safari, Android Chrome)

### Performance Audit
- [ ] Run Lighthouse audit (target: Performance > 90)
- [ ] Check total SVG payload size
- [ ] Verify lazy-loading for below-fold illustrations
- [ ] Test with throttled network (3G simulation)
- [ ] Check Core Web Vitals (LCP, CLS, INP)

### Accessibility Audit
- [ ] Screen reader testing (VoiceOver, NVDA)
- [ ] Keyboard navigation through interactive SVGs
- [ ] Verify `prefers-reduced-motion` disables all animation
- [ ] Check colour contrast in both light/dark themes
- [ ] Validate ARIA labels on decorative vs informative SVGs

### Final Sign-Off
- [ ] Stakeholder review of all illustration pages
- [ ] Final animation timing adjustments
- [ ] Documentation complete and up to date
- [ ] Tag release v1.0.0
- [ ] Archive raw assets and close Phase 4
