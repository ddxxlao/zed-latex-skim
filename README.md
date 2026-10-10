# zed-latex-skim

Write LaTeX in [Zed](https://zed.dev) with a live PDF in [Skim](https://skim-app.sourceforge.io) on macOS:
save to build, and jump between source and PDF in both directions.

| | |
|---|---|
| `⌘S` | build with latexmk; Skim reloads and shows the line you are on |
| `⌘⌥J` | jump from the Zed line to the PDF |
| `⌘⇧`-click in Skim | jump from the PDF to the Zed line |
| `⌘⌥B` | run the build task (`make` if the project has a Makefile) |
| `⌘⇧R` | tasks: pull, open PDF, build, check, list notes |

It is two small pieces of config, generated for you:

- **per machine** (`zed-latex setup`): Skim's auto-reload and its "open in editor" command, and two Zed keybindings.
- **per project** (`zed-latex init`): a `.zed/` folder with texlab build settings, tasks, and a cheat sheet.

## Install

Requirements: macOS, [Zed](https://zed.dev) with its command-line tool, MacTeX, Skim.

```sh
brew install --cask zed skim mactex-no-gui
brew install poppler        # optional: pdfinfo, used by many paper Makefiles
# In Zed: command palette (⌘⇧P) > "cli: install"
# In Zed: Extensions (⌘⇧X) > install "LaTeX"
```

Then install `zed-latex` (no sudo; it goes in `~/.local/bin`, added to your PATH if needed) and run its one-time setup:

```sh
curl -fsSL https://raw.githubusercontent.com/ddxxlao/zed-latex-skim/main/install.sh | sh
```

This clones the tool to `~/.local/share/zed-latex-skim` and runs `zed-latex setup`, which checks the tools,
writes Skim's preferences (restart Skim afterwards if it was open), and adds the keybindings to
`~/.config/zed/keymap.json`. An existing keymap is backed up to `keymap.json.bak` before it is changed.
Run the same command again to update.

## Use it on a paper

```sh
zed-latex init ~/papers/my-paper
zed ~/papers/my-paper
```

`init` finds the root document (the `.tex` file with `\documentclass`; `main.tex` wins a tie) and writes
`.zed/settings.json`, `.zed/tasks.json` and `.zed/README.md`, the cheat sheet you can open later with `⌘P` → `.zed/README`.
Open the project root in Zed, not a subfolder.

A repository with several documents (paper, rebuttal, slides) works too: `⌘⌥J` shows the line in the PDF of
whichever document includes the current file, found through `\input`/`\include`/`\subfile` or a
`% !TEX root = ../main.tex` line at the top of the file. `--main` only picks the PDF that `latex: open PDF in Skim` opens.

| Option | |
|---|---|
| `--main paper/main.tex` | choose the root document when there are several |
| `--engine xelatex` | `pdflatex` (default), `xelatex` or `lualatex` |
| `--note-tags 'TODO\|FIXME\|HY'` | comment tags that `latex: list notes` finds |
| `--share` | keep `.zed/` visible to git so co-authors get it (they need `zed-latex` installed too); by default it goes in `.git/info/exclude` |
| `--force` | overwrite an existing `.zed/` |

The first time you open a `.tex` file, Zed's LaTeX extension downloads texlab, which does the build on save.
Builds from Zed add `-synctex=1`, which the source–PDF jumps need.

## Notes in the source

Comments like `% REVIEW: …` or `% TODO: …` leave feedback in the source without changing the PDF or its page count.
`⌘⇧R` → `latex: list notes` lists them with clickable `file:line` links.

## Working with co-authors or an agent on another machine

- Pull before you start (`latex: pull`), push small commits often.
- `.tex` files are not reformatted on save; whole-file reindents are what turn pulls into conflicts.

## Troubleshooting

- **Skim does not reload:** Skim → Settings → Sync: turn on "Check for file changes" and "Reload automatically".
- **`⌘⇧`-click does nothing:** the PDF needs a `.synctex.gz` next to it. Build once with `⌘S`; a plain `make` usually does not write one.
- **`⌘⇧`-click opens a new Zed window:** Skim's arguments must be `-e "%file":%line` (rerun `zed-latex setup`).
- **`⌘⌥J` does nothing:** a macOS notification says why: the file is not included by any document, or the PDF is not built yet.
- **Changed `.zed/settings.json` has no effect:** restart Zed.

## License

MIT
