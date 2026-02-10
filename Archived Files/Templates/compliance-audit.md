---
description: Compliance Audit Mode (Manual)
---

# Compliance Audit Mode (Manual)
1) Start with this exact line:
   Ruleset: ZzLearns-GOV v1.0

2) State what you can and cannot verify:
   - If you cannot truly detect which rule files are active, say so explicitly.
   - Do NOT guess file paths or activation states.

3) Produce a short compliance checklist (PASS/FAIL) against the current user request:
   - No invented game ideas unless user asked for ideas
   - Suggestions OFF unless user said "Suggestions ON"
   - Missing info => ask targeted questions before implementing
   - Conflicts => stop and ask how to proceed
   - Workspace boundaries respected (only repo files)
   - asmdef rule: no folder contains multiple asmdefs
   - Docs rule: completed tasks update Docs/Logbook/YYYY-MM-DD.md

4) Then proceed with the normal response format:
   Understanding
   Questions/Conflicts (only if needed)
   Plan
   Changes
   How to Test
   Rollback Notes
   Documentation Updated