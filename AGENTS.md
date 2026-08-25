# AGENTS.md

## Project

This repository is a Typst port of the Gemini beamerposter theme for academic posters. The public example is a generic, self-contained two-column A1 poster. Keep changes focused, readable, and compatible with the repository's existing Typst style.

## Repository map

- `lib.typ`: template implementation and public API (`poster`, block types, and helpers).
- `themes.typ`: built-in color theme dictionaries.
- `poster.typ`: generic example poster and the main build target.
- `refs.bib`: bibliography used by the example.
- `fonts/`: vendored Montserrat and Source Sans 3 fonts plus their licenses.
- `preview/`: committed PNG previews used by `README.md`.
- `typst.toml`: future Typst Universe package metadata; it does not control local compilation.

## Build and validation

Typst 0.13 or newer is required; CI currently uses Typst 0.15.

Always expose the vendored fonts when compiling. A build without `--font-path fonts` may succeed while silently using incorrect fallback fonts.

```sh
make
make watch
make preview
make fonts
```

Equivalent direct build:

```sh
typst compile --font-path fonts poster.typ
```

For changes to `lib.typ`, `themes.typ`, `poster.typ`, fonts, or layout:

1. Run `make` and require a successful compile.
2. Inspect the rendered poster for overflow, clipping, awkward column breaks, and font substitution.
3. Run `make preview` when the public example or built-in themes change, and keep the committed README previews in sync.
4. Test each affected theme through `--input theme=<name>` when theme behavior changes.

## Implementation conventions

- Preserve the public API documented in `README.md` unless the task explicitly requires a breaking change.
- Put reusable layout and component behavior in `lib.typ`, theme colors in `themes.typ`, and demonstration content in `poster.typ`.
- Keep every theme dictionary compatible with the keys in `themes.navy`; custom dictionaries intentionally fall back to that theme.
- Use Typst-native figures in the committed example so it remains self-contained. Do not add example-only binary figures unless requested.
- Keep poster copy concise and suitable for large-format reading. Blocks are unbreakable, so watch their height when adding content.
- Preserve the theme selection through `sys.inputs` in `poster.typ`; `make preview` depends on it.
- If a public function, theme, build command, or repository layout changes, update `README.md` and comments that describe it.
- Do not modify vendored font files or license files unless the font set is intentionally being changed.

## Private-content boundary

- `local/` contains private research material and is gitignored. Never copy its names, contact details, unpublished results, bibliography, figures, or other content into tracked files or responses.
- `logos/` is gitignored because it may contain trademarked institutional assets. Do not commit those assets.
- Keep `poster.typ` generic: use placeholder authors, public/example citations, and synthetic Typst-drawn figures.
- If private poster compilation is explicitly requested, use:

```sh
typst compile --root . --font-path fonts local/poster-ragusa-recine.typ local/poster.pdf
```

## Change hygiene

- Respect existing user changes and avoid unrelated formatting or rewrites.
- Do not commit generated `poster.pdf` unless explicitly requested.
- Before handing off, report the files changed and the validation commands run.
