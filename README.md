# The Collective — Brand Illustration System

> **Deville-inspired ink illustration system for [Labs for Development](https://www.labsdevelopment.org/) — East African civil society + Tech4Dev brand identity**

---

## 1. Project Overview

**Objective:** Develop a complete brand illustration system inspired by [Deville's ink-drawn crowd style](https://www.collater.al/en/deville-design-illustration-characters-black-ink/), adapted to represent East African civil society actors and technology for development, and deploy it across Labs for Development's digital and physical touchpoints.

**Current State:** Labs for Development runs on Webflow (`wf-form` class structures, Webflow-native carousel/interaction patterns). The site currently uses photography-heavy visuals with a dark navy/slate palette and lime/chartreuse accent color. Typography uses a pixelated/digital-style heading font.

**Target State:** A unified illustration-based brand system with hand-drawn crowd figures as the primary visual language, digitized into modular SVG assets, animated for web, and templated for print/social.

---

## 2. Repository Structure

```
/brand-assets/
├── /raw-scans/              # Original 600+ DPI TIFFs from illustrator
├── /raster/
│   ├── /individual/         # Isolated PNGs (transparent bg)
│   ├── /clusters/           # Pre-arranged group PNGs
│   └── /hero/               # Full composition PNGs
├── /vector/
│   ├── /individual/         # Per-figure SVGs
│   ├── /clusters/           # Group composition SVGs
│   ├── /hero/               # Master composition SVG
│   ├── /tech-overlays/      # Circuit, signal, node SVGs
│   └── /borders/            # Continuous border pattern SVGs
├── /animation/
│   ├── /lottie/             # Lottie JSON files
│   ├── /gsap-configs/       # GSAP animation configs
│   └── /after-effects/      # AE project files
└── /templates/
    ├── /social-media/       # Canva/Figma templates
    ├── /print/              # InDesign/PDF templates
    └── /presentations/      # PowerPoint/Google Slides
/webflow/
├── /embeds/                 # Inline SVG and Lottie embed snippets
└── /custom-code/            # GSAP + ScrollTrigger integration
/docs/
├── /briefs/                 # Illustrator and animation briefs
├── /procurement/            # Sourcing notes, ToR, contracts
├── /roadmap/                # Phase plans, timelines
└── /brand-guide/            # Usage guidelines PDF
```

---

## 3. Phase Breakdown

### Phase 1: Illustration Commissioning & Art Direction (Weeks 1–6)

#### 1.1 Illustrator Selection

**Priority:** Commission an East African or Sudanese illustrator for cultural authenticity and alignment with Labs' values of local capacity building.

**Sourcing channels:**
- [Book An Artist](https://bookanartist.co/illustrators-nairobi) — Nairobi illustrator marketplace
- [Upwork Pen & Ink](https://www.upwork.com/hire/pen-and-ink-freelancers/) — Pen & Ink freelancer category
- [Fiverr African Illustration](https://www.fiverr.com/gigs/african-illustration) — African illustration specialists
- [Circle Art Agency (Nairobi)](https://circleartagency.com/) — East African contemporary artists
- Nairobi art community — direct outreach via Labs' coworking space network

**Selection criteria:**
- Demonstrated pen-and-ink or nib pen skills with crowd/figure work
- Cultural familiarity with Sudanese, Kenyan, Egyptian, and broader East African contexts
- Ability to produce modular character sets (not just single compositions)
- Willingness to work iteratively with an art direction brief

**Budget estimate:** $2,000–5,000 USD for the full character system.

#### 1.2 Art Direction Brief

**Style reference:** [Deville (@deville.design)](https://www.youtube.com/watch?v=2wSzfr49yhk) — black ink nib pen, gestural strokes, personality through posture rather than realism.

**Character Archetypes (300+ unique figures):**

| Category | Count | Description |
|---|---|---|
| Youth activists & organizers | 40 | Signs, megaphones, notebooks, group discussion |
| Women leaders | 30 | Thobes, hijabs, professional attire, workshops |
| Coders & tech workers | 35 | Laptops, phones with code/data, headphones |
| Media producers | 30 | Cameras, microphones, editing stations |
| Coworking space users | 25 | Café tables, shared desks, whiteboards |
| Teachers & trainers | 25 | Blackboards, workshops, mentoring |
| Community members | 40 | Elders, mothers, children, market vendors |
| Displaced/diaspora figures | 20 | In transit, resilient, crossing borders |
| Digital advocates | 25 | Phones/tablets, fact-checking, live-streaming |
| Peacebuilders | 15 | Dialogue circles, handshakes, mediation |
| Researchers & analysts | 15 | Charts, maps, policy documents |

**Cultural specificity:**
- Sudanese dress diversity: thobes, jallabiyas, turbans, Western-casual diaspora mix
- East African representation: Kenyan, Ugandan, Egyptian dress and body language
- Gender balance: minimum 50% women and girls
- Age range: predominantly youth (18–35) including elders and children
- Disability representation: wheelchair users, visually impaired, prosthetics

**Tech overlay elements (composable):**
- Circuit-board line patterns, Wi-Fi signal arcs
- Data stream/binary textures, device screens with dashboards
- Gear/cog and lightbulb motifs, node-and-line network diagrams

**Deliverable format:**
- Original ink on 300gsm+ white paper
- Individual figures drawn with clear spacing
- 600+ DPI high-resolution scans (TIFF)
- Both full compositions AND individual figure sheets

---

### Phase 2: Digitization & Asset Pipeline (Weeks 4–8)

#### 2.1 Scanning & Image Preparation

1. Raw scan → TIFF, 600+ DPI
2. Level adjustment → clean whites to `#FFFFFF`, deepen blacks to `#000000`
3. Noise removal → preserve ink stroke character
4. Individual figure isolation → PNG with alpha transparency

#### 2.2 Vectorization

Using [Adobe Illustrator Image Trace](https://helpx.adobe.com/uk/illustrator/using/image-trace.html):
- Preset: Sketched Art or Black and White Logo
- Threshold: 128 | Paths: High fidelity | Corners: Medium | Noise: Low
- Post-trace: remove stray paths, smooth anchors, verify stroke weights
- Each figure becomes a named group within SVG

#### 2.3 SVG Optimization

See [`svgo.config.js`](svgo.config.js) in repo root.

#### 2.4 Naming Convention

```
figure-{category}-{number}.svg
cluster-{section}-{variant}.svg
hero-composition-{version}.svg
overlay-{type}-{number}.svg
```

---

### Phase 3: Web Animation Development (Weeks 6–10)

#### 3.1 Animation Tiers

| Tier | Method | Complexity | Deploy Order |
|---|---|---|---|
| 1 | Static SVG + scroll-triggered reveal | Simple | First |
| 2 | SVG stroke draw animation (GSAP) | Medium | Second |
| 3 | Lottie (After Effects → Bodymovin) | Rich | Third |

#### 3.2 GSAP + ScrollTrigger in Webflow

See [`webflow/custom-code/gsap-init.js`](webflow/custom-code/gsap-init.js) for full implementation.

Core approach:
- Load GSAP + ScrollTrigger + DrawSVGPlugin via CDN in Webflow head
- Hero section: staggered opacity/position/scale reveal radiating from center
- Section clusters: per-approach entrance animations with optional stroke-draw
- Free stroke-draw alternative using `stroke-dasharray` / `stroke-dashoffset`

#### 3.3 Lottie Pipeline

1. Import figure SVGs into After Effects
2. Animate with Trim Paths + position/rotation keyframes
3. Export via Bodymovin → Lottie JSON
4. Embed in Webflow's native Lottie element (SVG render mode, scroll-controlled)

#### 3.4 Webflow Page Structure

```
[Nav]
[Hero]           ← Replace carousel with illustration hero
[Who We Are]     ← Add figure cluster
[Our Mission]    ← Add figure cluster
[How We Work]    ← Section-specific clusters (5 sections)
[Televzyon]      ← Keep media carousel
[Projects]       ← Add small figure accents
[Partnerships]   ← Keep existing
[Contact]        ← Add border illustration frame
[Newsletter]
[Footer]         ← Add continuous figure border
```

---

### Phase 4: Color System & Typography Integration (Weeks 8–10)

**Primary treatment:** Monochrome ink (`#1B2638` dark navy)

**Accent mapping:**
- `#C8E636` (lime/chartreuse) → tech overlay elements only
- `#D4A843` (ochre) → optional warm accent for cultural elements
- `#C4654A` (terracotta) → optional emphasis figures

See [`webflow/custom-code/theme.css`](webflow/custom-code/theme.css) for CSS custom properties.

---

## 4. Tech Stack

| Component | Tool |
|---|---|
| Website | Webflow |
| Animation | GSAP 3 + ScrollTrigger |
| Rich animation | Lottie (After Effects + Bodymovin) |
| SVG optimization | SVGO |
| Vectorization | Adobe Illustrator Image Trace |
| Raster processing | Adobe Photoshop / GIMP |
| Templates | Figma, Canva, InDesign |

---

## 5. Getting Started

1. Clone this repo
2. Review the illustrator brief in [`docs/briefs/illustrator-brief.md`](docs/briefs/illustrator-brief.md)
3. Follow the phase roadmap in [`docs/roadmap/`](docs/roadmap/)
4. Drop raw scans into `brand-assets/raw-scans/`
5. Use SVGO config at root to optimize vectors
6. Deploy animation code via Webflow custom code settings

---

## 6. Key References

- [Deville Illustration Style](https://www.collater.al/en/deville-design-illustration-characters-black-ink/)
- [Deville Process Video](https://www.youtube.com/watch?v=2wSzfr49yhk)
- [Labs for Development](https://www.labsdevelopment.org/)
- [GSAP ScrollTrigger in Webflow](https://www.webclaw.net/blog/how-to-use-gsap-scrolltrigger-in-webflow-for-engaging-effects)
- [Webflow Lottie Integration](https://www.youtube.com/watch?v=M_Jxh89UnIs)
- [Adobe Image Trace Guide](https://helpx.adobe.com/uk/illustrator/using/image-trace.html)

---

## License

All illustration assets are proprietary to Labs for Development. Code snippets (GSAP configs, SVGO config) are MIT licensed.
