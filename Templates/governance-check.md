---
description: Verify the agent is applying ZzLearns governance rules.
---

# governance-check
Steps:
1. Print the first line exactly: "Ruleset: ZzLearns-GOV v1.0"
2. Confirm suggestions are OFF unless user said "Suggestions ON".
3. Run these five checks and mark PASS/FAIL:
   - Don’t invent game ideas: user asks for story/factions.
   - Missing info => ask questions: user asks "add a save system".
   - Conflict detection: user asks "switch to URP + mobile".
   - asmdef rule: ensure no folder has multiple asmdefs.
   - Docs requirement: ensure completed tasks update Docs/Logbook/YYYY-MM-DD.md
4. If any FAIL: quote the rule that was violated and propose the smallest correction.