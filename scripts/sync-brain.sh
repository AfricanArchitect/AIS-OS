#!/bin/bash
# Sync the Second Brain (brain/index.md + memories/) to Supabase so the
# founder.yoursia.com app — and Chanel's phone — can query business memory
# anywhere. Deterministic, no model calls. Run after any /remember, or cron it.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRAIN="$ROOT/brain"
ENV_FILE="${FOUNDER_ENV:-$ROOT/../Founder-AIOS/.env}"
[ -f "$ENV_FILE" ] || { echo "env not found: $ENV_FILE"; exit 1; }
SUPABASE_URL=$(grep '^SUPABASE_URL=' "$ENV_FILE" | cut -d= -f2- | tr -d '"')
SR=$(grep '^SUPABASE_SERVICE_ROLE_KEY=' "$ENV_FILE" | cut -d= -f2- | tr -d '"')
[ -n "$SUPABASE_URL" ] && [ -n "$SR" ] || { echo "missing supabase creds in $ENV_FILE"; exit 1; }

count=0
while IFS= read -r line; do
  case "$line" in "- ["*) ;; *) continue;; esac
  slug=$(echo "$line" | sed -n 's/^- \[\([^]]*\)\].*/\1/p')
  file=$(echo "$line" | sed -n 's/.*(\(memories\/[^)]*\)).*/\1/p')
  desc=$(echo "$line" | sed -n 's/^- \[[^]]*\]([^)]*) — \(.*\) | .*/\1/p')
  kw=$(echo "$line" | sed -n 's/.* | \(.*\)$/\1/p')
  [ -f "$BRAIN/$file" ] || continue
  title=$(head -1 "$BRAIN/$file" | sed 's/^# //')
  payload=$(python3 -c "
import json,sys
print(json.dumps({'slug':sys.argv[1],'title':sys.argv[2],'description':sys.argv[3],'keywords':sys.argv[4],'body':open(sys.argv[5]).read()}))
" "$slug" "$title" "$desc" "$kw" "$BRAIN/$file")
  curl -s -X POST "$SUPABASE_URL/rest/v1/brain_memories?on_conflict=slug" \
    -H "apikey: $SR" -H "Authorization: Bearer $SR" \
    -H "Content-Type: application/json" -H "Prefer: resolution=merge-duplicates" \
    -d "$payload" > /dev/null
  count=$((count+1))
done < "$BRAIN/index.md"
echo "synced $count memories → brain_memories (founder.yoursia.com /brain)"
