#!/usr/bin/env sh
# Wraps the artifact page bodies in src/ into standalone HTML files.
set -e
cd "$(dirname "$0")"
wrap() {
  {
    printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<style>:root{color-scheme:dark}body{margin:0;font:14px system-ui,sans-serif}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
    cat "$1"
    printf '\n</body>\n</html>\n'
  } > "$2"
  echo "built $2 ($(wc -c < "$2") bytes)"
}
wrap src/game.html index.html
wrap src/game3d.html index3d.html
