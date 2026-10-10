# zed-latex-skim

在 macOS 上用 [Zed](https://zed.dev) 写 LaTeX，用 [Skim](https://skim-app.sourceforge.io) 实时看 PDF：保存即编译，源码和 PDF 双向跳转。

[English](README.md)

| | |
|---|---|
| `⌘S` | 用 latexmk 编译；Skim 自动刷新并显示光标所在行 |
| `⌘⌥J` | 从 Zed 当前行跳到 PDF |
| Skim 里 `⌘⇧`+点击 | 从 PDF 跳回 Zed 对应行 |
| `⌘⌥B` | 运行编译任务（项目有 Makefile 时用 `make`） |
| `⌘⇧R` | 任务列表：拉取、打开 PDF、编译、检查、列出批注 |

整个工具就是两份配置，由脚本生成：

- **每台机器一次**（`zed-latex setup`）：Skim 的自动刷新和"跳回编辑器"命令，加两个 Zed 快捷键。
- **每个项目一次**（`zed-latex init`）：在项目里生成 `.zed/`，包括 texlab 编译设置、任务和速查表。

## 安装

需要：macOS、Zed（及其命令行工具）、MacTeX、Skim。

```sh
brew install --cask zed skim mactex-no-gui
brew install poppler        # 可选：提供 pdfinfo，很多论文的 Makefile 用它数页数
# Zed 里：命令面板（⌘⇧P）> "cli: install"
# Zed 里：扩展（⌘⇧X）> 安装 "LaTeX"
```

然后：

```sh
git clone https://github.com/ddxxlao/zed-latex-skim ~/.local/share/zed-latex-skim
ln -s ~/.local/share/zed-latex-skim/zed-latex /usr/local/bin/zed-latex   # 或 PATH 上任意位置
zed-latex setup
```

`setup` 会检查工具、写入 Skim 偏好设置（最好先退出 Skim，或之后重启它），并把快捷键加进 `~/.config/zed/keymap.json`。
已有的 keymap 修改前会备份为 `keymap.json.bak`。

## 在论文项目里使用

```sh
zed-latex init ~/papers/my-paper
zed ~/papers/my-paper
```

`init` 会自动找主文件（含 `\documentclass` 的 `.tex`，有多个时优先 `main.tex`），生成 `.zed/settings.json`、`.zed/tasks.json`
和速查表 `.zed/README.md`（以后在 Zed 里 `⌘P` → `.zed/README` 打开）。用 Zed 打开项目根目录，不要只开子文件夹。

| 选项 | |
|---|---|
| `--main paper/main.tex` | 有多个主文件时指定一个 |
| `--engine xelatex` | `pdflatex`（默认）、`xelatex` 或 `lualatex`（中文文档用 xelatex） |
| `--note-tags 'TODO\|FIXME\|HY'` | `latex: list notes` 要找的注释标记 |
| `--share` | 不把 `.zed/` 排除出 git，提交后合作者也能用；默认写进 `.git/info/exclude`，只在本机 |
| `--force` | 覆盖已有的 `.zed/` |

第一次打开 `.tex` 时，Zed 的 LaTeX 扩展会自动下载 texlab，保存时由它编译。
从 Zed 编译会加 `-synctex=1`，双向跳转靠它。

## 源码批注

用 `% REVIEW: …`、`% TODO: …` 这样的注释写意见：PDF 里不显示，不影响页数。
`⌘⇧R` → `latex: list notes` 会列出所有批注，`文件:行号` 可点击跳转。

## 和合作者或另一台机器上的 Agent 协作

- 开始前先拉取（`latex: pull`），小步提交、勤推送。
- `.tex` 保存时不自动格式化：整文件重排缩进是拉取冲突的主要来源。

## 排错

- **Skim 不刷新：** Skim → 设置 → 同步，勾选"检查文件变化"和"自动重新载入"。
- **`⌘⇧`+点击没反应：** PDF 旁边需要有 `.synctex.gz`。用 `⌘S` 编译一次；直接 `make` 通常不生成它。
- **`⌘⇧`+点击后 Zed 新开了窗口：** Skim 的参数应为 `-e "%file":%line`（重新运行 `zed-latex setup`）。
- **改了 `.zed/settings.json` 不生效：** 重启 Zed。

## 许可证

MIT
