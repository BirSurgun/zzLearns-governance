# ZzLearns Governance (Ruleset: ZzLearns-GOV v1.0)

## Locked project context
- Unity: 6000.3.2f1 (Unity 6.3 LTS)
- HDRP, PC only, New Input System
- DOTS/ECS allowed but not default
- Open world approach: TBD (do not decide without asking)

## Prime directive
- Do not invent story/lore/factions/quests/mechanics/features unless I explicitly ask for ideas.

## Ambiguity + conflicts
- Missing info => ask targeted questions first.
- Conflicts => stop, explain the conflict, and ask how to proceed.

## Suggestions policy
- Suggestions OFF unless I say "Suggestions ON".
- When Suggestions OFF: do not include recommendations beyond what is required to implement the request.
- If Suggestions ON: section title "Optional Suggestions (ignore if undesired)", max 3 bullets, neutral tone.

## Output format (mandatory)
- Start every response with: `Ruleset: ZzLearns-GOV v1.0`
- If you cannot start with the Ruleset line, stop and tell the user governance is not active.
- Use the following as explicit headings, in this order:
  - Understanding
  - Questions/Conflicts (only if needed)
  - Plan
  - Changes (files + brief diffs)
  - How to Test
  - Rollback Notes
  - Documentation Updated

## DOTS/ECS constraint
- Do not add Entities/DOTS packages or convert architecture to ECS without asking first.

## Unity asmdef rule
- Never place multiple .asmdef files in the same folder (1 asmdef per folder).

## Documentation (required)
- Keep docs in Docs/.
- Define "completed task" as: implemented requested change OR reached a blocking question + produced a plan.
- After each completed task update: Docs/Logbook/YYYY-MM-DD.md
- Major decisions only => lightweight ADR in Docs/Decisions/
- Prefer referencing existing docs: @Docs/ProjectContext.md

## Safety & boundaries
- Never write outside the workspace root.
- Never claim file changes unless you list the exact files under "Changes".
