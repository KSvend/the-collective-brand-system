/**
 * GSAP + ScrollTrigger Animation Init for The Collective
 * 
 * Deploy: Paste into Webflow Site Settings > Custom Code > Before </body>
 * 
 * Dependencies (add to <head> custom code):
 *   <script src="https://cdn.jsdelivr.net/npm/gsap@3.12/dist/gsap.min.js"></script>
 *   <script src="https://cdn.jsdelivr.net/npm/gsap@3.12/dist/ScrollTrigger.min.js"></script>
 *   <!-- Optional: DrawSVGPlugin requires GSAP Club ($99/yr) -->
 *   <!-- <script src="https://cdn.jsdelivr.net/npm/gsap@3.12/dist/DrawSVGPlugin.min.js"></script> -->
 */

document.addEventListener('DOMContentLoaded', function () {
  gsap.registerPlugin(ScrollTrigger);

  // =========================================================
  // 1. HERO SECTION — Progressive crowd reveal
  // =========================================================
  const heroFigures = document.querySelectorAll(
    '.hero-illustration .figure-group'
  );

  if (heroFigures.length) {
    gsap.from(heroFigures, {
      opacity: 0,
      y: 20,
      scale: 0.8,
      duration: 0.4,
      stagger: {
        each: 0.02,
        from: 'center',
        grid: 'auto',
      },
      scrollTrigger: {
        trigger: '.hero-illustration',
        start: 'top 85%',
        toggleActions: 'play none none none',
      },
    });
  }

  // =========================================================
  // 2. SECTION CLUSTERS — Per-section entrance animations
  // =========================================================
  const sectionClusters = [
    { selector: '.cluster-capacity-building', xFrom: -30, rotation: -5 },
    { selector: '.cluster-content-creation', xFrom: 30, rotation: 5 },
    { selector: '.cluster-coworking', xFrom: -20, rotation: -3 },
    { selector: '.cluster-research-policy', xFrom: 20, rotation: 3 },
    { selector: '.cluster-tech-ai', xFrom: 0, rotation: 0 },
  ];

  sectionClusters.forEach(function (section) {
    const figures = document.querySelectorAll(
      section.selector + ' .figure-group'
    );
    if (figures.length) {
      gsap.from(figures, {
        opacity: 0,
        x: section.xFrom,
        rotation: section.rotation,
        duration: 0.6,
        stagger: 0.03,
        scrollTrigger: {
          trigger: section.selector,
          start: 'top 75%',
          toggleActions: 'play none none reverse',
        },
      });
    }
  });

  // =========================================================
  // 3. TECH OVERLAY — Circuit line draw animation
  // =========================================================
  // Free alternative to DrawSVGPlugin using stroke-dasharray
  const drawPaths = document.querySelectorAll('.draw-effect path');

  drawPaths.forEach(function (path) {
    var length = path.getTotalLength();
    path.style.strokeDasharray = length;
    path.style.strokeDashoffset = length;

    gsap.to(path, {
      strokeDashoffset: 0,
      duration: 1.5,
      ease: 'power2.out',
      scrollTrigger: {
        trigger: path.closest('.figure-group') || path.closest('svg'),
        start: 'top 80%',
      },
    });
  });

  // Tech overlay circuit lines (if using DrawSVGPlugin)
  // Uncomment if you have GSAP Club access:
  /*
  var techOverlayPaths = document.querySelectorAll('.tech-overlay path');
  if (techOverlayPaths.length) {
    gsap.from(techOverlayPaths, {
      drawSVG: '0%',
      duration: 2,
      ease: 'power2.inOut',
      stagger: 0.1,
      scrollTrigger: {
        trigger: '.cluster-tech-ai',
        start: 'top 70%',
        scrub: 1,
      },
    });
  }
  */

  // =========================================================
  // 4. FOOTER BORDER — Continuous figure border parallax
  // =========================================================
  var footerBorder = document.querySelector('.footer-illustration');
  if (footerBorder) {
    gsap.from(footerBorder, {
      opacity: 0,
      y: 40,
      duration: 1,
      scrollTrigger: {
        trigger: footerBorder,
        start: 'top 90%',
        toggleActions: 'play none none none',
      },
    });
  }

  // =========================================================
  // 5. CONTACT FRAME — Border illustration reveal
  // =========================================================
  var contactFrame = document.querySelector('.contact-illustration-frame');
  if (contactFrame) {
    var framePaths = contactFrame.querySelectorAll('path');
    framePaths.forEach(function (path) {
      var len = path.getTotalLength();
      path.style.strokeDasharray = len;
      path.style.strokeDashoffset = len;
    });

    gsap.to(contactFrame.querySelectorAll('path'), {
      strokeDashoffset: 0,
      duration: 2,
      stagger: 0.05,
      ease: 'power2.inOut',
      scrollTrigger: {
        trigger: contactFrame,
        start: 'top 75%',
      },
    });
  }

  console.log('[The Collective] GSAP animations initialized.');
});
