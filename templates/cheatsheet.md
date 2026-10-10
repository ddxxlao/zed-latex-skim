# Zed + Skim cheat sheet / 速查

Root document / 主文件: `@MAIN@`

| Action / 操作 | Keys / 按键 |
|---|---|
| Save and build; Skim reloads and jumps to the cursor / 保存并编译，Skim 刷新并跳到光标处 | `⌘S` |
| Zed line → PDF / 源码 → PDF | `⌘⌥J` |
| PDF → Zed line / PDF → 源码 | `⌘⇧`-click in Skim / 在 Skim 中 `⌘⇧`+点击 |
| Run the build task / 运行编译任务 | `⌘⌥B` |
| All tasks / 任务列表 | `⌘⇧R` |
| Open a file (e.g. this one) / 打开文件（比如本文件） | `⌘P` → `.zed/README` |
| Search the project / 全项目搜索 | `⌘⇧F` |

## Tasks / 任务（`⌘⇧R`）

- `latex: pull` — `git pull --rebase --autostash`
- `latex: open PDF in Skim` — open the PDF / 打开 PDF
- `latex: build` — `make` if there is a Makefile, otherwise latexmk / 有 Makefile 用 make，否则用 latexmk
- `latex: check` — `make check` (only if the Makefile has it / Makefile 有 check 目标时才有)
- `latex: list notes` — every `% @NOTE_TAGS@:` comment, clickable / 列出所有批注注释，可点击跳转

## Notes in the source / 源码批注

Write feedback as LaTeX comments: invisible in the PDF, so they never change the page count.
用 LaTeX 注释写意见：PDF 里不显示，不影响页数。

```latex
% REVIEW: lead with the floor guarantee, then the speedup.
% TODO(hy): replace with the measured number.
```

## Troubleshooting / 排错

- Skim does not reload / Skim 不刷新: Skim → Settings → Sync → check "Check for file changes" and "Reload automatically".
- `⌘⇧`-click does nothing / 点击无反应: build once with `⌘S` (it writes the `.synctex.gz`; plain `make` usually does not).
- Settings ignored / 配置没生效: restart Zed.
- Reconfigure / 重新生成: `zed-latex init --force` (this file is overwritten too / 本文件也会被覆盖).
