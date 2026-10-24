# Stop That Runner!

A playable browser prototype of the reverse-runner described in
`docs/Stop_That_Runner_Development_Document.pdf`. You are ARC, the old city AI.
Kip stole the memory core and runs for the edge of the city. You place traps
ahead of him. Every crash scores, every checkpoint he passes drains your energy.

The design doc targets Unity/C# on Android. This repo is the HTML5 canvas
prototype of the same loop, so the design can be played and tuned before the
Unity build starts. Everything runs on-device in the browser, no backend.

## Retrograde (second game)

`retrograde.html` (source `src/retrograde.html`) is a separate, original
time-inversion puzzle game built on the same Three.js pipeline. You play Noor
Idris, a sweeper for the Halvard Containment Office. Each site is one timeline:
run it forward, step through the turnstile, then live the same seconds
backwards while your forward self replays in reverse beside you.

- **Credit.** A closed door can be opened on credit: a future inverted you
  promises to hold its switch. Inverted, you must be on that switch before the
  countdown reaches the red bar and stay until it passes, or the timeline folds.
- **Reciprocity.** Any switch you hold forward is also held at those seconds
  for your inverted self (gold marks on the timeline).
- **Turrets.** Bullet positions are pure functions of the clock, so forward
  rounds fly back into their guns when inverted, and inverted turrets show the
  bullet hole before the shot.
- Eight sites with a short original story, relics to collect, local progress.

## Two builds of Stop That Runner!

| File | What it is |
|------|------------|
| `index3d.html` (source `src/game3d.html`) | 3D build on Three.js r128: rigged runner (knees, elbows, face, hair, jacket, glowing stolen core, scarf with secondary motion), procedural run cycle with squash and stretch, per-trap ragdoll crashes, chase camera with speed FOV, sun and soft shadows, shader sky with clouds, HDR bloom, vignette and FXAA, per-world road surfaces, weather particles, street lights, billboards and glowing checkpoint gates. Same rules as the 2D build. |
| `index.html` (source `src/game.html`) | 2D canvas build with the 2.5D side view. No dependencies at all. |

Open either file in a modern browser (phone or desktop). No build step is
needed to play. `./build.sh` wraps the two `src/` pages into the standalone
files. The 3D build loads Three.js from cdnjs, so it needs network access the
first time; everything else is inline. Each build keeps its own save data.

## Play

| Gesture        | Trap            | Energy |
|----------------|-----------------|--------|
| Tap            | Barrier wall    | 10     |
| Swipe down     | Hole            | 15     |
| Swipe sideways | Rolling barrel  | 20     |
| Hold 1 s       | Falling crane   | 40     |
| Double tap     | This world's unique trap | varies |

Desktop: keys 1 to 7 arm a trap, click to place, P pauses. Tapping a dock
button also arms that trap.

## What is implemented from the design doc

- **Core loop**: auto-running AI runner, endless scrolling track, energy bar,
  checkpoints every 300 m (energy -15, speed +5 %), crash refills 20 energy,
  run ends when energy hits zero.
- **Scoring**: base 100, combo x1.5 when two traps chain within 2 s, +50
  surprise bonus for a trap type not yet seen this run, half points when the
  same trap is used three times in a row.
- **World generator**: 20 m chunks picked by rules (no two gaps in a row, room
  for traps between gaps), five worlds that change every 1,000 m with a blended
  transition: City Streets, Jungle Temple, Snow Mountain, Space Station, Candy
  Land. Each world has its own unique trap and runner trait.
- **Runner AI**: utility AI that scores jump, slide, lane switch, slow down and
  dash; a memory of your last five trap types that makes spammed traps easier
  to dodge; personality weights; long-term memory across runs.
- **Content combiner**: traps are base + modifier + world element (Freezing
  Frost barrel, Tall Neon wall...). Runners are movement + resistance + quirk +
  look, built from modular parts. Every combination is checked for
  beatability before it appears.
- **Difficulty director**: tracks your crash rate, targets about 60 % wins,
  raises runner awareness and spawns rarer variants when you win easily, eases
  off after repeated escapes.
- **Story**: five glitch files unlock by total distance across all runs; the
  final choice (Order or Freedom) appears in Candy Land once all files are
  decoded. Both endings keep endless mode going.
- **Modes**: Endless, Daily challenge (seeded by date, same track for
  everyone), Puzzle (three hand-built levels with fixed trap sets).
- **Progression**: coins upgrade the four base traps, player level unlocks
  Pop mine (level 3) and Net launcher (level 6), leaderboards for best score,
  the week's most crashes, and the daily seed, and a runner collection book.
- **UX and accessibility**: tutorial with icon hints only, colourblind-safe
  trap colours with distinct shapes, haptics toggle, left-hand mode, adaptive
  synth music that adds drums and bass as speed rises, slow-motion crash cam.

Not in this prototype: Duel mode, cloud leaderboards, ads and purchases,
shareable crash videos, and the optional cloud generative AI. Progress is saved
in the browser's local storage.
