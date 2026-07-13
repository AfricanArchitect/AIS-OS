---
name: recall
description: Deterministic Second Brain retrieval — use when Chanel asks a factual question about her own setup, business, decisions, or history ("what's the supabase ref", "when is the launch", "which email does m365 use", "what did we decide about X"). Runs code, not model reads — keywords → score index → open exactly ONE file.
---

## What this does

`scripts/recall.sh "<question>"` climbs the ladder from the Second Brain guide:
1. Strips the question to keywords (filler discarded)
2. Scores every `brain/index.md` line WITHOUT opening any files
3. Opens only the single best-scoring memory
4. Follows at most one `see: memories/x.md` pointer
The model (you) only sees the question + the retrieved evidence, and answers once.

## Execution

1. Run: `bash scripts/recall.sh "<Chanel's question>"`
2. Answer from the retrieved memory ONLY. Cite the memory file name.
3. If exit code 2 (no match): say the brain has no memory on this, answer from
   general context if safe, and offer to `/remember` the answer once confirmed.
4. Never open multiple memory files "just in case" — one file, that's the discipline.

## Why this exists

Most lookups need zero intelligence. Deterministic retrieval keeps sessions
cheap and answers grounded. If recall keeps missing on a topic, the fix is a
better index line or a new memory — not more model reads.
