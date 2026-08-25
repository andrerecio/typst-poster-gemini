# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Typst port of the "Gemini" beamerposter LaTeX theme (Anish Athalye, MIT; via the gemini-cam fork) for two-column academic posters. Canonical repo: `andrerecio/typst-poster-gemini`.

## Build commands

Requires `typst` on PATH (Typst ≥ 0.13; CI pins 0.15).

- `make` — compile `poster.typ` → `poster.pdf`
- `make watch` — live preview, recompiles on save
- `make preview` — regenerates `preview/poster-navy.png` and `preview/poster-sapienza.png` (the images embedded in the README) via `--input theme=<name>`
- `make fonts` — verify Typst sees the vendored fonts
- Without make: `typst compile --font-path fonts poster.typ`

**Always pass `--font-path fonts`.** Montserrat and Source Sans 3 are vendored in `fonts/`; without the flag Typst silently falls back to other fonts and the poster still compiles but looks wrong. Math uses New Computer Modern Math, which ships with Typst.

## Architecture

- `lib.typ` — the template library. `poster(...)` is the entry point, used as `#show: poster.with(...)`; it sets up page, header (title/authors/institute/logos grid), footer band, typography, and column layout. The active theme is stored in `state("poster-theme")` so block functions read it via `context`. Block system: `poster-block(title, kind:, body)` with wrappers `plain-block` / `example-block` / `alert-block` (beamer's `block` / `exampleblock` / `alertblock`). Helpers: `figure-box`, `arrows-list` ("⇒" bullets), `accent`.
- `themes.typ` — four colour themes (`navy`, `sapienza`, `navy-filled`, `sapienza-filled`) as dictionaries with identical keys. `poster(theme: ...)` accepts a theme name (string) or a dictionary; missing dictionary keys fall back to `navy` (`_resolve-theme` in lib.typ).
- `poster.typ` — the committed generic example poster. Reads the theme from `sys.inputs` (`--input theme=...`, defaults to `navy`) so `make preview` can render both themes from one file. Its figures are drawn in Typst (`demo-bars`, `demo-scatter`) so no binary figure files are committed.
- `typst.toml` — manifest for a future Typst Universe release only; `typst compile` ignores it.
- `.github/workflows/build.yml` — CI: compiles the poster and uploads the PDF artifact.

## Repo policy — private content

- `local/` is **gitignored** and holds Andrea's personal research poster (`local/poster-ragusa-recine.typ`, `local/refs.bib`, `local/figs/`, old previews). Never commit it, and never leak its content (author names, email `...@uniroma1.it`, unpublished results) into tracked files. Build it with `typst compile --root . --font-path fonts local/poster-ragusa-recine.typ local/poster.pdf`.
- `logos/` (Sapienza University logos, trademarked) is also gitignored; the `sapienza` themes are just colours and stay in the repo.
- The committed `poster.typ` must remain a generic example (placeholder authors/content, Typst-drawn figures).
- `preview/*.png` ARE committed (the README embeds them) — regenerate with `make preview` whenever the example or themes change.
