# Animation Specifications

> Reference document for all SVG animation behaviours in The Collective brand system.

## Global Animation Defaults

| Property | Value |
|----------|-------|
| Default duration | 0.8s |
| Default ease | `power2.out` |
| Scroll trigger start | `top 80%` |
| Scroll trigger end | `bottom 20%` |
| Reduced motion | All animations disabled; static state shown |
| Frame budget | < 16ms (60fps target) |

---

## Animation Categories

### 1. Scroll Reveal

**Trigger:** Element enters viewport via ScrollTrigger.

| Parameter | Value |
|-----------|-------|
| Initial state | `opacity: 0; y: 30` |
| End state | `opacity: 1; y: 0` |
| Duration | 0.8s |
| Ease | `power2.out` |
| Stagger (groups) | 0.15s |
| CSS class | `.svg-animate` |

**Usage:** Applied to all illustration containers that should reveal on scroll.

### 2. Hover Micro-Interactions

**Trigger:** `mouseenter` / `mouseleave` on interactive SVG elements.

| Parameter | Value |
|-----------|-------|
| Scale on hover | 1.05 |
| Duration | 0.3s |
| Ease | `power1.out` |
| CSS class | `.svg-hover` |

**Usage:** Spot illustrations, icon elements, interactive diagram nodes.

### 3. Path Drawing

**Trigger:** ScrollTrigger or page load.

| Parameter | Value |
|-----------|-------|
| Initial state | `strokeDashoffset: length` |
| End state | `strokeDashoffset: 0` |
| Duration | 1.5s |
| Ease | `power1.inOut` |
| CSS class | `.svg-draw` |

**Usage:** Line-art illustrations, decorative borders, connecting paths.

### 4. Colour Morph

**Trigger:** Theme toggle or scroll position.

| Parameter | Value |
|-----------|-------|
| Property | `fill` / `stroke` via CSS custom properties |
| Duration | 0.4s |
| Ease | `none` (linear) |
| CSS class | `.svg-morph` |

**Usage:** Theme-responsive illustrations that shift between light/dark palettes.

### 5. Lottie Playback

**Trigger:** Viewport entry or interaction.

| Parameter | Value |
|-----------|-------|
| Autoplay | false (triggered on scroll) |
| Loop | Configurable per asset |
| Speed | 1x default |
| Renderer | SVG |
| Max file size | 50KB per animation |

**Usage:** Complex hero animations, loading states, brand moments.

---

## SVG Layer Naming Convention

Illustrator must use the following layer-naming pattern for GSAP targeting:

```
[category]-[element]-[index]
```

**Examples:**
- `hero-figure-01`
- `spot-leaf-03`
- `bg-gradient-01`
- `icon-arrow-02`

These layer names become CSS class names after SVGO processing.

---

## Class Mapping

| SVG Class | Animation Type | Trigger |
|-----------|---------------|--------|
| `.svg-animate` | Scroll reveal | ScrollTrigger |
| `.svg-hover` | Hover scale | mouseenter/leave |
| `.svg-draw` | Path drawing | ScrollTrigger |
| `.svg-morph` | Colour morph | Theme toggle |
| `.svg-lottie` | Lottie playback | ScrollTrigger |

---

## Performance Guidelines

1. **Animate only transform and opacity** where possible (GPU-composited)
2. **Avoid animating layout properties** (width, height, top, left)
3. **Use `will-change: transform`** on animated SVG containers
4. **Batch DOM reads/writes** in GSAP timelines
5. **Lazy-load below-fold SVGs** using Intersection Observer
6. **Target < 50KB** per optimised SVG illustration
7. **Test on low-end devices** (throttled CPU in DevTools)

---

## Accessibility Requirements

- All animations respect `prefers-reduced-motion: reduce`
- Interactive SVGs must be keyboard-focusable
- Decorative SVGs: `aria-hidden="true"`, `role="presentation"`
- Informative SVGs: `role="img"`, `<title>` and `<desc>` elements
- Animated content must not flash more than 3 times per second
