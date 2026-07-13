---
name: remember
description: Store a new memory in the Second Brain — use when Chanel says "remember this", "save this fact", "add to memory", "note that", or states a durable fact worth keeping (a decision, a credential location, a launch date, a rule). Writes the memory file AND its index line in one deterministic step, no model calls.
---

## What this does

One command stores a memory: `scripts/remember.sh "<title>" "<fact>" "[keywords]"`.
It writes `brain/memories/<slug>.md` and appends the one-line catalogue entry to `brain/index.md` in the same step, so the index can never drift.

## Execution

1. Distill what Chanel said into: a short kebab-ready title, a 1–4 sentence fact (facts only — no chat filler), and 4–8 lowercase keywords someone would search with later.
2. Run: `bash scripts/remember.sh "<title>" "<fact>" "<keywords>"`
3. Echo back the stored index line so she sees exactly what the brain kept.
4. If the script says the memory exists, read the existing file and either update it in place (edit file + fix its index line) or pick a more specific title.

## Rules

- Interpreted facts only. Never dump raw transcripts or emails into a memory.
- One fact per file. Two facts = two calls.
- Durable info only — things true next month. Session trivia doesn't get stored.
- Respect naming rules (SUPERI not YSIA, etc.) inside memory text.
