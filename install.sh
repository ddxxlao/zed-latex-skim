#!/bin/sh
# Install zed-latex without sudo:
#   curl -fsSL https://raw.githubusercontent.com/ddxxlao/zed-latex-skim/main/install.sh | sh
# or, from a clone: ./install.sh
set -eu

REPO=https://github.com/ddxxlao/zed-latex-skim
SRC=${ZED_LATEX_HOME:-$HOME/.local/share/zed-latex-skim}
BIN=$HOME/.local/bin

here=$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)
if [ -n "$here" ] && [ -f "$here/zed-latex" ]; then
  SRC=$here                                  # running from a clone: use it
elif [ -d "$SRC/.git" ]; then
  git -C "$SRC" pull -q --ff-only            # reinstall: update
else
  git clone -q "$REPO" "$SRC"
fi

mkdir -p "$BIN"
ln -sf "$SRC/zed-latex" "$BIN/zed-latex"
echo "ok    zed-latex -> $BIN/zed-latex"

case ":$PATH:" in
  *":$BIN:"*) ;;
  *)
    rc=$HOME/.zshrc
    [ "${SHELL##*/}" = bash ] && rc=$HOME/.bash_profile
    if ! grep -qs '.local/bin' "$rc"; then
      printf '\n# zed-latex\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$rc"
      echo "ok    added ~/.local/bin to PATH in $rc (open a new terminal)"
    fi
    PATH=$BIN:$PATH
    ;;
esac

echo
"$BIN/zed-latex" setup
