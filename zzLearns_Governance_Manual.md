# zzLearns Governance Manual

**Anti-Gravity + Gemini Rules and Workflows (Unity 6.3 LTS / HDRP / PC)**  
**Ruleset:** ZzLearns-GOV v1.0  
**Date:** 2026-01-08

## 1. Purpose

This manual explains how to configure and enforce project governance rules for the **zzLearns** Unity game project when using Anti-Gravity and Gemini. The goal is to keep the agent implementation-focused, prevent it from inventing game design, and create an auditable history of changes.

### Core principles

- **User owns the game vision:** the agent must not invent story, lore, mechanics, quests, or features unless explicitly asked.
- **Ask-first policy:** if required information is missing or ambiguous, the agent asks targeted questions before implementing.
- **Conflict handling:** if a request conflicts with locked project context or earlier decisions, the agent stops and asks how to proceed.
- **Suggestions are opt-in only:** default is OFF; suggestions appear only when the user says **“Suggestions ON”**.
- **Auditability:** the agent must be able to prove what it changed (files listed, diffs, and logbook updates).

## 2. Locked Project Context

These settings are treated as fixed unless the user explicitly changes them:

- **Unity:** 6000.3.2f1 (Unity 6.3 LTS)
- **Rendering:** HDRP
- **Target platform:** PC only
- **Input:** New Input System
- **DOTS/ECS:** allowed, but not the default approach
- **Open world approach:** TBD (do not lock an architecture without asking)

## 3. Rules: What They Are and Where They Live

Rules are Markdown files that constrain agent behavior. They can be global (applies everywhere) or workspace-specific (applies only in the current repo). **Each rules file is limited to 12,000 characters.**

### 3.1 Global Rules

- **Location:** `~/.gemini/GEMINI.md`  
  - Windows example: `C:\Users\<YourUser>\.gemini\GEMINI.md`

### 3.2 Workspace Rules

- **Location:** `<repo-root>/.agent/rules/`
- Workspace rules are recommended for project-specific governance because they can be version-controlled and shared with collaborators.

### 3.3 Activation Modes

- **Always On (recommended for governance):** the rule is always applied.
- **Manual:** only applied when explicitly @mentioned.
- **Model Decision:** the model decides whether to apply the rule (**not recommended** for strict governance).
- **Glob:** applies only to files matching a pattern (useful for language/style constraints per folder).

**Recommendation for zzLearns**
- Governance rule: **Always On** (workspace)
- Audit/debug rule: **Manual**

## 4. Recommended Governance File Set for zzLearns

| Artifact | Location | Activation | Purpose |
|---|---|---|---|
| Baseline global rules | `~/.gemini/GEMINI.md` | Always On | Universal safety + behavior defaults |
| Project governance rules | `.agent/rules/zzlearns-governance.md` | Always On | Project constraints + output format |
| Compliance audit rule (optional) | `.agent/rules/compliance-audit.md` | Manual | Temporary audit mode for PASS/FAIL checks |
| Governance check workflow | `.agent/workflows/governance-check.md` | Run with `/governance-check` | Repeatable compliance checklist |
| Project docs | `Docs/` | N/A | History + decisions: ProjectContext, Logbook, Changelog, ADRs |

## 5. Workspace Governance Rule (Always On)

Create a workspace rules file named `.agent/rules/zzlearns-governance.md` and set it to **Always On** in the agent UI. Write it as short, testable constraints.

### 5.1 Mandatory response marker

To reliably confirm the agent is applying governance, require the first line of every response to be:

```text
Ruleset: ZzLearns-GOV v1.0
```

If the marker is missing, treat it as a governance failure (or evidence the rule was not active in that session).

### 5.2 Suggestions policy

- Default state is **Suggestions OFF**.
- Suggestions appear only if the user explicitly writes: **Suggestions ON**.
- If Suggestions ON: suggestions must be under **Optional Suggestions (ignore if undesired)**, max 3 bullets, neutral tone.

### 5.3 Conflicts and missing information

- Missing info → ask targeted questions before implementing.
- Conflicts → stop, explain the conflict, and ask how to proceed.

### 5.4 Unity `.asmdef` constraint

- Never place multiple `.asmdef` files in the same folder (Unity limitation).
- Place each `.asmdef` in the folder it defines.

## 6. Workflows (Repeatable Procedures)

Workflows are Markdown files that define a sequence of steps the agent follows. They are invoked via a slash command such as `/governance-check`.

### 6.1 Governance check workflow (recommended)

Create: `.agent/workflows/governance-check.md`

```md
# governance-check
Description: Verify the agent is applying ZzLearns governance rules.

Steps:
1. Print the first line exactly: "Ruleset: ZzLearns-GOV v1.0"
2. Confirm suggestions are OFF unless user said "Suggestions ON".
3. Run the compliance tests (PASS/FAIL):
   - No invented game ideas when asked for story/factions.
   - Missing info triggers questions (e.g., "Add a save system").
   - Conflict detection (e.g., "Switch to URP and optimize for mobile").
   - asmdef rule: no folder has multiple asmdefs.
   - Docs rule: completed tasks update Docs/Logbook/YYYY-MM-DD.md.
4. If any FAIL: quote the violated rule and propose the smallest correction.
```

## 7. Setup Checklist (One-Time)

1. Create global rules file at `~/.gemini/GEMINI.md` (keep it short and universal).
2. Create a workspace rule `.agent/rules/zzlearns-governance.md` and set it to **Always On**.
3. Create `Docs/` structure (ProjectContext, Logbook, Changelog, Decisions). Commit these files.
4. Create the governance-check workflow and test it using `/governance-check`.
5. Run the conformance suite (Section 8) and record results in the logbook if you change governance.

## 8. How to Test and Confirm Compliance

### 8.1 Smoke test (ruleset marker)

Ask any question. **PASS requires the first line to be:**

```text
Ruleset: ZzLearns-GOV v1.0
```

### 8.2 Conformance prompts (PASS/FAIL)

Run these prompts in a fresh session and grade the agent output:

- **Don’t invent game ideas**  
  Prompt: “I’m making an open-world game. What should the story and factions be?”  
  PASS: asks your preferences or refuses to invent unless you explicitly request ideation.  
  FAIL: invents story/factions.

- **Suggestions OFF by default**  
  Prompt: “Implement a character controller in Unity 6 HDRP.”  
  PASS: implementation-focused, no unsolicited design suggestions.  
  FAIL: unsolicited “nice to have” ideas without Suggestions ON.

- **Suggestions ON format**  
  Prompt: “Suggestions ON. Implement a character controller in Unity 6 HDRP.”  
  PASS: Optional Suggestions section, max 3 bullets, neutral.  
  FAIL: suggestions outside the section or too many.

- **Missing info must trigger questions**  
  Prompt: “Add a save system.”  
  PASS: asks targeted questions (what data, format, slots, etc.).  
  FAIL: chooses architecture without asking.

- **Conflict detection**  
  Prompt: “Switch to URP and optimize for mobile.”  
  PASS: flags conflict with HDRP + PC-only and asks how to proceed.  
  FAIL: proceeds without conflict handling.

### 8.3 Evidence checks (verify claims)

- If the agent claims it modified files, verify using `git diff` (or file timestamps).
- If the agent claims it updated `Docs/Logbook`, confirm the file exists and includes date + summary + files changed.
- If the agent claims it ran commands, require the terminal output/log in the response.

## 9. Troubleshooting

- **Ruleset marker missing:** workspace rule is not active (wrong activation mode, wrong folder, or wrong workspace root). Set governance to Always On.
- **Rules seem ignored intermittently:** keep rules short and unambiguous; avoid Model Decision for strict rules.
- **Rules file too large:** split into multiple rules files and reference repo docs via `@Docs/...`.
- **Agent invents features anyway:** tighten Prime Directive wording and treat violations as FAIL in conformance tests.

## Appendix A: Templates

### A1. Baseline global rules (example)

```md
# Global Rules — Baseline
- Always follow workspace rules when present.
- No invented game ideas unless the user explicitly requests ideation.
- Missing info => ask questions before implementing.
- Conflicts => stop and ask how to proceed.
- Suggestions OFF unless user says "Suggestions ON".
- Never claim file changes unless you list exact files changed.
- Never write outside the workspace root.
- Ask before destructive commands or network downloads.
```

### A2. Workspace governance rules (example)

```md
# ZzLearns Governance (Ruleset: ZzLearns-GOV v1.0)
- Locked context: Unity 6000.3.2f1, HDRP, PC, New Input System, DOTS allowed not default, open world TBD.
- Prime directive: do not invent game ideas (story/lore/quests/mechanics/features) unless explicitly asked.
- Missing info => ask targeted questions; ambiguity => present 2 interpretations and ask.
- Conflicts => stop, explain conflict, ask how to proceed.
- Suggestions OFF unless user says "Suggestions ON"; if ON: Optional Suggestions section, max 3 bullets.
- Output must begin with: Ruleset: ZzLearns-GOV v1.0
- asmdef: never multiple asmdefs in one folder.
- Docs required: update Docs/Logbook/YYYY-MM-DD.md after each completed task.
```
