#!/bin/bash
# Store a memory: writes the file AND its index line in ONE step. No model.
# Usage: scripts/remember.sh "short-title" "the fact, one or more sentences" "optional keywords"
set -euo pipefail
BRAIN_DIR="$(cd "$(dirname "$0")/../brain" && pwd)"
TITLE="${1:?usage: remember.sh <title> <fact> [keywords]}"
FACT="${2:?usage: remember.sh <title> <fact> [keywords]}"
KW="${3:-}"
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//')
FILE="$BRAIN_DIR/memories/$SLUG.md"
[ -f "$FILE" ] && { echo "memory '$SLUG' exists — pick a new title or edit $FILE"; exit 1; }
DESC=$(echo "$FACT" | head -c 140 | tr '\n' ' ')
[ -z "$KW" ] && KW=$(echo "$TITLE $DESC" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' ' ' | tr ' ' '\n' | awk 'length($0)>3' | sort -u | head -8 | tr '\n' ' ')
printf '# %s\n%s\n' "$TITLE" "$FACT" > "$FILE"
printf -- '- [%s](memories/%s.md) — %s | %s\n' "$SLUG" "$SLUG" "$DESC" "$KW" >> "$BRAIN_DIR/index.md"
echo "stored: $FILE"
echo "indexed: $(tail -1 "$BRAIN_DIR/index.md")"
