# Zed + Skim cheat sheet

Root document: `@MAIN@` (`⌘⌥J` finds the right PDF for any file, even with several documents)

| Action | Keys |
|---|---|
| Save and build; Skim reloads and jumps to the cursor | `⌘S` |
| Zed line → PDF | `⌘⌥J` |
| PDF → Zed line | `⌘⇧`-click in Skim |
| Run the build task | `⌘⌥B` |
| All tasks | `⌘⇧R` |
| Open a file (e.g. this one) | `⌘P` → `.zed/README` |
| Search the project | `⌘⇧F` |

## Tasks (`⌘⇧R`)

- `latex: pull` — `git pull --rebase --autostash`
- `latex: open PDF in Skim` — open the PDF
- `latex: build` — `make` if there is a Makefile, otherwise latexmk
- `latex: check` — `make check` (only if the Makefile has a `check` target)
- `latex: list notes` — every `% @NOTE_TAGS@:` comment, with clickable `file:line` links

## Notes in the source

Write feedback as LaTeX comments: they are invisible in the PDF, so they never change the page count.

```latex
% REVIEW: lead with the floor guarantee, then the speedup.
% TODO(hf): replace with the measured number.
```

## Troubleshooting

- Skim does not reload: Skim → Settings → Sync → turn on "Check for file changes" and "Reload automatically".
- `⌘⇧`-click does nothing: build once with `⌘S` (it writes the `.synctex.gz`; a plain `make` usually does not).
- Settings ignored: restart Zed.
- Regenerate: `zed-latex init --force` (this file is overwritten too).
