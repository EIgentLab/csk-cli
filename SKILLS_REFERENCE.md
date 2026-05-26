# CSK Skills Reference

Complete reference for all 36 skills in the Company Skill Kit (CSK). Each skill produces a specific deliverable artifact with CSK frontmatter, traceability links, and sign-off blocks.

> **Quick start:** `csk install` → invoke any skill in Claude Code. Browse with `csk skills list` or `csk skills search "<keyword>"`.

---

## P0 — Discovery

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 1 | `csk-stakeholder-interview` | Interview Script + Notes | template · quick | Generate a semi-structured stakeholder interview script (BABOK-aligned) with time-boxed agenda, categorized question bank, follow-up prompts, anti-leading checklist, and post-interview synthesis fields. Use at project kickoff in P0 Discovery. |
| 2 | `csk-jtbd` | JTBD Canvas | template · quick | Generate a Jobs-To-Be-Done canvas with Christensen Job Stories, Ulwick ODI statements, 3 dimensions (functional/emotional/social), Forces of Progress, current solutions, evidence quotes, priority matrix, and assumption validation plan. |
| 3 | `csk-persona` | Persona Document | template | Generate a single Persona document anchored in real data — Goals/Anti-goals, Pain Points, Behaviors, Context, JTBD link, Motivations, Channels, Success Metrics, and linked-journeys placeholder for `csk-journey-map` handoff. |
| 4 | `csk-journey-map` | Customer Journey Map | quick · template | Generate a per-persona × scenario Journey Map with 3–7 phases (action/thought/emotion/touchpoint/pain/opportunity), emotion curve, RTM seed linking pains to opportunities, and explicit persona link. |
| 5 | `csk-user-research` | Research Plan + Report | quick · template | Generate a User Research Plan with objectives, hypotheses, methods (qual/quant), participant criteria, recruitment, discussion guide, schedule, success criteria, ethics/consent. Optional Findings + Recommendations sections in report mode. |

---

## P1 — Inception

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 6 | `csk-vision-board` | Vision Board | template | Generate a Lean Inception Vision Board (Paulo Caroli 7-cell elevator pitch) plus Product is/is-not table. Vision data comes from workshops — the template scaffold captures outputs, not fabricates them. |
| 7 | `csk-lean-canvas` | Lean Canvas | quick · template | Generate an Ash Maurya 9-block Lean Canvas — Problem, Customer Segments, UVP, Solution, Channels, Revenue Streams, Cost Structure, Key Metrics, Unfair Advantage — with assumption tags [A]/[V], OMTM, CAC+LTV, and validation plan. |
| 8 | `csk-feature-catalog` | Feature Catalog (YAML) | quick · template | Generate a YAML-enumerated feature catalog grouped by epic, scored Value/Effort/Risk, prioritized via MoSCoW, linked to personas. Output is YAML (not markdown) for git-versioning, machine-validation, and diffability. |

---

## P2 — Definition & Design

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 9 | `csk-prd` | PRD | quick · template | Generate a Product Requirements Document with 8-section structure, FR/NFR tables, success metrics, non-goals, dependencies, risks, and sign-off block ready for Spec Freeze. |
| 10 | `csk-srs` | SRS-light | quick · template | Generate a Software Requirements Specification following IEEE 830 + ISO 29148 + ISO 25010, with 6 mandatory sections, FR/NFR tables, external interfaces, RTM seed, change log, and sign-off block. |
| 11 | `csk-fsd` | FSD-light | quick · template | Generate a per-feature Functional Specification Document with FN/BR IDs, main/alternate/exception flows, business rules, edge cases, Given-When-Then AC, data validation, and UI/API refs ready for sprint intake. |
| 12 | `csk-c4-l1` | C4 Level 1 System Context | template | Generate a C4 L1 System Context diagram + narrative — the highest-leverage architecture artifact for stakeholder alignment. Includes Mermaid C4Context block, actors table, external systems table, scope IN/OUT, and key interactions narrative. |
| 13 | `csk-c4-l2` | C4 Level 2 Container | template | Generate a C4 L2 Container diagram + narrative showing web apps, APIs, DBs, message buses, workers. Includes Mermaid C4Container block, container list table (Tech/Responsibility/Owner/ADR), narrative per container, and approval block. |
| 14 | `csk-adr` | ADR (Architecture Decision Record) | quick · template | Generate a MADR-4.0 / Nygard hybrid ADR with decision drivers, ≥2 considered alternatives, both-sided consequences, and validation criteria. One ADR per decision — invoke multiple times for multiple decisions. |
| 15 | `csk-openapi` | OpenAPI 3.1 I/O Contract | quick · template | Generate an OpenAPI 3.1 REST API contract with RFC 9457 Problem Details errors, modular `$ref` layout, Spectral-lintable shape, securitySchemes, and components/schemas ready for `spectral lint` and Prism mock. |
| 16 | `csk-erd` | ERD (Schema-as-Code) | quick · template | Generate an Entity-Relationship Diagram as 3NF schema-as-code. Two formats: Prisma (default, ORM-integrated) or DBML (tool-agnostic, visualization-first). Includes naming conventions, FK constraints, indexes, soft-delete + audit columns. |
| 17 | `csk-wireframe` | Wireframe | template | Generate a wireframe deliverable locking layout, hierarchy, content placement, and screen flow — with ASCII layout placeholders, Mermaid flow, Figma frame refs, screen-state matrix, annotations, breakpoints, RACI, and sign-off block. |
| 18 | `csk-wireflow` | Wireflow (Screen Flow) | quick · template | Generate a wireflow document (screen layouts + flow arrows + decision branches) with Mermaid flowchart skeleton, screen-state transitions, happy/edge/error paths, story-to-screen mapping, and a11y notes. |
| 19 | `csk-design-system` | Design System | quick · template | Generate a Design System artifact with design tokens (color, spacing, typography, radius, shadow, motion) plus base components (button, input, card, modal). Extends `csk-brand`. Scope: tokens + base components (atoms/molecules). |
| 20 | `csk-brand` | Brand Guideline | template | Generate a Brand Guideline document tying Brand Strategy (mission/vision/values/positioning/archetype) to Brand Identity (logo/color/type/voice/imagery) and Application rules. Feeds `csk-design-system`. |
| 21 | `csk-test-strategy` | Test Strategy | template | Generate a project-wide Test Strategy defining the test pyramid, types, tools, coverage gates, environments, RACI over a 6-24 month horizon. 17 mandatory sections per ISO 29119-3. ONE strategy per project. |
| 22 | `csk-test-plan` | Test Plan | template | Generate a feature-level Test Plan (IEEE 829 / ISO 29119-3) with scope, approach, entry/exit criteria, environment, schedule, RACI, risks, manual-vs-auto matrix, and sign-off block. ONE plan per feature. |
| 23 | `csk-test-cases` | Test Cases Bundle | quick · template | Generate a bundle of test cases for a single User Story — hybrid Gherkin + IEEE 829 format, with TC-{NNN} IDs, automation flag, ISTQB derived-from technique, and bidirectional links to AC/Story. |
| 24 | `csk-rtm` | RTM (Requirements Traceability Matrix) | quick · template | Generate a Requirements Traceability Matrix linking User Stories ↔ Test Cases ↔ Code ↔ UAT. View modes: `--view active` (default), `--view history`, `--view revisions {id}`. `--update {path}` appends rows. Split by epic past 50 rows. |

---

## P3 — Planning

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 25 | `csk-wbs` | WBS (YAML) | quick · template | Generate a Work Breakdown Structure as YAML decomposing a project across 4 levels (L1 project → L2 phase → L3 epic → L4 task). Includes estimates (hours, T&M-honest), owners, acceptance criteria, 100% rule satisfied. Output is YAML for git-versioning. |
| 26 | `csk-roadmap` | Product Roadmap | quick · template | Generate a Now-Next-Later Product Roadmap with Mermaid Gantt for the Now bucket, 3-5 themes, success metrics per item, dependencies, risks, and change log — ready to drive sprint planning and stakeholder syncs. |
| 27 | `csk-sprint-planning` | Sprint Planning Ceremony | quick · template | Generate a Sprint Planning ceremony plan with SMART sprint goal, capacity calc, candidate story list, two-topic agenda (What + How), risks, and verbal commit block. Distinct from `csk-sprint-backlog`. |
| 28 | `csk-sprint-backlog` | Sprint Backlog | quick · template | Generate a Sprint Backlog (committed story list + task breakdown) for a single sprint. The WHAT + HOW table that Developers update daily during the sprint. Distinct from `csk-sprint-planning` (the ceremony). |
| 29 | `csk-raci` | RACI Matrix | quick · template | Generate a RACI matrix mapping SDLC artifacts to role accountability. Prefilled from Q6 §10 phase map. Enforces one-A-per-row invariant. |
| 30 | `csk-risk-register` | Risk Register | quick · template | Generate or extend a project Risk Register with per-risk rows (likelihood × impact = score, owner, mitigation, contingency, trigger, status) and traceability back to WBS / Vision. |

---

## P4 — Sprint Loop

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 31 | `csk-user-story` | User Story + AC | quick · `--bulk` | Generate a single User Story with INVEST-checked As-a/I-want/So-that statement, Given-When-Then AC table, DoR checklist, and upstream traceability to FSD/SRS. `--bulk` generates multiple stories from an epic spec. |
| 32 | `csk-bug-report` | Bug Report | quick · template | Generate a Bug Report with enforced severity (S1-S4) + priority (P1-P4) enums, mandatory steps-to-reproduce, expected vs actual behavior, and environment block. ID format: BUG-{NNN}. Output: `.project/deliverables/04-quality/bugs/`. |
| 33 | `csk-validate` | Validation Report | (single mode) | Validate a filled CSK artifact against its source skill's DoR/DoD checklist. Deterministic PASS/FAIL audit per checklist item. Invocation: `csk-validate --skill csk-{artifact} {file-path}`. |
| 34 | `csk-revise` | Revised Artifact | (single mode) | Atomic revise + backup for any csk-* artifact. Backs up current version, applies edit, bumps semver, updates change_log, validates, refreshes RTM, and emits an impact report. Refuses files lacking `id:` frontmatter. |

---

## P5 — Release & UAT

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 35 | `csk-uat` | UAT Package | template · quick | Generate a complete UAT package: UAT Plan + UAT Test Cases + Execution Log + Sign-off. 4 deliverables with CSK frontmatter ready for Gate 5: Customer UAT Sign-off. |

---

## Cross-Phase (Any)

| # | Skill | Artifact | Modes | Description |
|---|-------|----------|-------|-------------|
| 36 | `csk-conduct` | Execution Plan | advisory · execute | Unified Q&A front-door + cross-phase workflow conductor. Search (file/ref lookup), discover (skill recommendation), or workflow (phase orchestration) branches. `--advisory` returns execution plan markdown; `--execute` spawns owner agents per artifact. |

> **Note:** `csk-orchestrate` is listed as a cross-phase skill in some contexts — it provides multi-agent orchestration capabilities that coordinate multiple skills across phases.

---

## Skill Modes Explained

| Mode | Behavior | When to use |
|------|----------|-------------|
| **quick** | Interactive interview — asks each required field in turn | When you have the content in your head and want to fill it incrementally |
| **template** | Fill-yourself scaffold — generates structure with placeholders | When the artifact requires workshop/stakeholder input the LLM cannot fabricate |
| **advisory** | Returns an execution plan as markdown (no file writes) | When you want to see what `csk-conduct` would do before running it |
| **execute** | Spawns owner agents, gates via `csk-validate` | When you want `csk-conduct` to actually produce deliverables |
| **bulk** | Generates multiple items from a parent spec | When you need many user stories from one epic (currently `csk-user-story` only) |

---

## Using Skills in Claude Code

After `csk install`, skills are available as slash commands in Claude Code:

```
/ck:prd                    # Generate a PRD (quick mode)
/ck:prd --template         # Generate a PRD scaffold (template mode)
/ck:user-story --bulk      # Generate multiple user stories from an epic
/ck:validate --skill csk-prd path/to/prd.md
/ck:conduct                 # Meta-router: what should I do next?
```

### Common Workflows

**P0 → P1 Discovery & Inception:**
```
/ck:stakeholder-interview  →  /ck:jtbd  →  /ck:persona  →  /ck:journey-map
/ck:vision-board  →  /ck:lean-canvas  →  /ck:feature-catalog
```

**P2 Definition & Design:**
```
/ck:prd  →  /ck:srs  →  /ck:fsd
/ck:c4-l1  →  /ck:c4-l2  →  /ck:adr
/ck:openapi  →  /ck:erd
/ck:wireframe  →  /ck:wireflow  →  /ck:design-system
/ck:test-strategy  →  /ck:test-plan  →  /ck:test-cases
/ck:rtm
```

**P3 Planning:**
```
/ck:wbs  →  /ck:roadmap  →  /ck:sprint-planning  →  /ck:sprint-backlog
/ck:raci  →  /ck:risk-register
```

**P4 Sprint Loop:**
```
/ck:user-story  →  /ck:test-cases  →  implement  →  /ck:bug-report
/ck:validate --skill csk-user-story path/to/story.md
/ck:revise path/to/artifact.md
```

**P5 Release & UAT:**
```
/ck:uat  →  customer sign-off  →  deploy
```

---

## Skill Output Locations

All skills write artifacts to `.project/deliverables/` organized by phase:

```
.project/deliverables/
├── p0-discovery/          # Personas, Journey Maps, JTBD, Research Reports
├── p1-inception/          # Vision Board, Feature Catalog, Lean Canvas
├── p2-definition/         # PRD, SRS, FSD, ADR, C4, OpenAPI, ERD, Wireframes, Test artifacts
├── p3-planning/            # WBS, Roadmap, Sprint Plans, RACI, Risk Register
├── p4-quality/             # User Stories, Bug Reports, Validation Reports
│   └── bugs/              # Bug reports (BUG-{NNN})
├── p5-release/             # UAT packages, Release Notes, Runbooks
└── p6-maintenance/         # Incident Reports, Patch Notes
```

After creating or editing deliverables, always rebuild the index:

```bash
csk db rebuild              # Regenerate artifacts.csv + refs.csv
csk broken-refs             # Catch missing cross-refs
```

---

## CSK Frontmatter Schema

Every skill-produced artifact includes this YAML frontmatter for traceability:

```yaml
---
id: PRD-001                # Unique artifact ID (type prefix + NNN)
type: prd                   # Artifact type
version: "1.0"              # Semantic version (bumped by csk-revise)
status: draft               # draft → review → approved → superseded
phase: P2                   # SDLC phase
owners: [po]                # Role(s) responsible
upstream: [VISION-001]      # IDs of source artifacts this derives from
implements: [FEAT-001]       # Feature or requirement IDs this satisfies
traces_to: [US-001, TC-001] # Downstream traceability targets
change_log:                 # Auto-maintained by csk-revise
  - version: "1.0"
    date: 2026-01-15
    author: po
    change: Initial draft
---
```

Key ID prefixes:

| Prefix | Artifact Type |
|--------|--------------|
| `FEAT-` | Feature (from Feature Catalog) |
| `VISION-` | Vision Board |
| `PRD-` | Product Requirements Document |
| `SRS-` | Software Requirements Specification |
| `FSD-` | Functional Specification Document |
| `ADR-` | Architecture Decision Record |
| `US-` | User Story |
| `TC-` | Test Case |
| `BUG-` | Bug Report |
| `UAT-` | UAT Test Case |
| `WBS-` | Work Breakdown Structure |
| `RISK-` | Risk Register Entry |

---

## Validation & Revision

### Validate an artifact

```bash
# Check a filled artifact against its skill's DoR/DoD checklist
/ck:validate --skill csk-prd .project/deliverables/p2-definition/prd-v1.md
```

### Revise an artifact

```bash
# Atomic revise: backup → edit → bump version → update RTM → impact report
/ck:revise .project/deliverables/p2-definition/prd-v1.md
```

Both commands require CSK frontmatter (`id:` field) in the target file.

---

## Related Documentation

- **README.md** — Installation, commands, and workflow guide
- **SKILLS_REFERENCE.md** (this file) — Detailed skill descriptions, modes, and usage
- **Q6 Condensed Workflow** — `.project/docs/sdlc-qa/06-condensed-workflow-small-team.md`