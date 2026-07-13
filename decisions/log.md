# Decisions Log

Append-only record of meaningful decisions and why they were made. `/level-up` Phase 2 (Method interview) writes scoped automation specs here. You can also append manually whenever you decide something worth remembering.

**Format per entry:**

```
## YYYY-MM-DD — Short title

**Decision:** what was decided.

**Why:** the reasoning, constraints, and what would change your mind.

**Alternatives considered:** what else was on the table.

**Owner:** who's accountable.
```

Keep it terse. Future-you will thank present-you for capturing the *why*, not just the *what*.

---

## 2026-06-15 — AIS-OS adopted as Chanel's local AIOS brain
**Decision:** Nate Herk's AIS-OS kit (this fork) becomes the brain on Chanel's Mac. founder.yoursia.com (repo Founder-AIOS) becomes the visualization + agent-profile layer over the same Supabase data. The 9 chiefs are kept and ported into agents/ as versioned persona files. A Second Brain (brain/ + deterministic recall/remember scripts) is added per the RoboNuggets principles.
**Reasoning:** AIS-OS gives the proven operator framework (3Ms, Four Cs, onboard/audit/level-up). Chanel's chiefs and live data plumbing are her differentiators — kept, not rebuilt. Deterministic retrieval keeps sessions cheap.
**Follow-ups:** Facecard/profile layer in the app; eventually package as forkable SIA business software.
**Context:** Bluë orchestrating; verified recall/remember round-trip on first build.
