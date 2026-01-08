# zzLearns Governance

Governance rules + workflows for using Anti-Gravity and Gemini on the **zzLearns** Unity project.

## Read the manual
- **Markdown (best for GitHub browsing):** `Docs/zzLearns_Governance_Manual.md`
- **PDF (print/share):** `Docs/zzLearns_Governance_Manual.pdf`
- **DOCX (editable):** `Docs/zzLearns_Governance_Manual.docx`

## What this repo contains
- `Docs/` — the governance manual in multiple formats
- `Templates/` — copy/paste templates for:
  - Global rules (`~/.gemini/GEMINI.md`)
  - Workspace rules (`.agent/rules/zzlearns-governance.md`)
  - Workflows (`.agent/workflows/governance-check.md`)

## Quick start
1. Put the global baseline rules at: `~/.gemini/GEMINI.md`
2. Add the workspace governance rule at: `.agent/rules/zzlearns-governance.md` and set it to **Always On**
3. Add the workflow at: `.agent/workflows/governance-check.md`
4. Run: `/governance-check`
