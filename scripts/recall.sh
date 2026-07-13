#!/bin/bash
# Deterministic Second Brain retrieval — zero model calls.
# Ladder: strip question to keywords → score every index line WITHOUT opening
# files → open only the single best memory → print it. Follow one pointer max.
# Usage: scripts/recall.sh "where does m365 mail pull from?"
set -euo pipefail
BRAIN_DIR="$(cd "$(dirname "$0")/../brain" && pwd)"
INDEX="$BRAIN_DIR/index.md"
Q="${*:-}"
[ -z "$Q" ] && { echo "usage: recall.sh <question>"; exit 1; }

# 1. Keywords: lowercase, strip filler.
STOP="the a an and or of to in on for with is are was were do does how what where when why who which my your our this that it its from at by as be can will should i you we"
KEYWORDS=$(echo "$Q" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' ' ' | tr ' ' '\n' | grep -vwF -f <(echo "$STOP" | tr ' ' '\n') | sort -u)
[ -z "$KEYWORDS" ] && { echo "no keywords extracted"; exit 1; }

# 2. Score index lines only (name + description + keywords field).
BEST=""; BEST_SCORE=0
while IFS= read -r line; do
  case "$line" in "- ["*) ;; *) continue;; esac
  lc=$(echo "$line" | tr '[:upper:]' '[:lower:]')
  score=0
  while IFS= read -r kw; do
    [ -z "$kw" ] && continue
    case "$lc" in *"$kw"*) score=$((score+1));; esac
  done <<< "$KEYWORDS"
  if [ "$score" -gt "$BEST_SCORE" ]; then BEST_SCORE=$score; BEST="$line"; fi
done < "$INDEX"

[ "$BEST_SCORE" -eq 0 ] && { echo "no memory matches. keywords tried:"; echo "$KEYWORDS"; exit 2; }

# 3. Open only the ONE best file.
FILE=$(echo "$BEST" | sed -n 's/.*(\(memories\/[^)]*\)).*/\1/p')
echo "── best match (score $BEST_SCORE): $FILE"
cat "$BRAIN_DIR/$FILE"

# 4. Follow one pointer max (a line like "see: memories/other.md").
PTR=$(grep -oE 'see: memories/[a-z0-9._-]+\.md' "$BRAIN_DIR/$FILE" | head -1 | sed 's/see: //') || true
if [ -n "${PTR:-}" ] && [ -f "$BRAIN_DIR/$PTR" ]; then
  echo "── pointer → $PTR"
  cat "$BRAIN_DIR/$PTR"
fi
