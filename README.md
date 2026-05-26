<div align="center">

# CSK CLI

**Company Skill Kit — Install, manage, and trace deliverables for Inception-Driven Standard Agile**

[![License: BUSL-1.1](https://img.shields.io/badge/License-BUSL--1.1-blue.svg)](https://github.com/EIgentLab/csk-cli/blob/main/LICENSE)
[![Go 1.26.3+](https://img.shields.io/badge/Go-1.26.3+-00ADD8.svg)](https://go.dev/)

[Install](#install) · [Quick Start](#quick-start) · [Commands](#commands) · [Workflow Guide](#workflow-guide) · [Skills & Agents](#skills--agents) · [Deliverables Index](#deliverables-index) · [Development](#development)

</div>

---

## What is CSK CLI?

`csk` is the command-line companion to the **Company Skill Kit (CSK)** — a suite of 36 skills + 10 role-based agents that power the **Inception-Driven Standard Agile** workflow for small teams (8-10 people).

It does three things:

| Capability | What it means |
|---|---|
| **Install & manage** | Ships embedded skills/agents — `csk install` drops them into `.claude/` so Claude Code can use them instantly |
| **Deliverables index** | Scans `.project/deliverables/`, builds a CSV index of every artifact (PRD, SRS, ADR, …) with frontmatter, cross-refs, and traceability |
| **Visualization & search** | Ripgrep-powered search, Mermaid diagram generation (graph / RTM / trace), orphan detection, ref validation — all from the CLI |

---

## Install

### macOS / Linux — curl

```bash
curl -fsSL https://raw.githubusercontent.com/EIgentLab/csk-cli/main/scripts/install.sh | bash
```

Install to a custom directory:

```bash
curl -fsSL https://raw.githubusercontent.com/EIgentLab/csk-cli/main/scripts/install.sh | bash -s -- --install-dir ~/bin
```

Install a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/EIgentLab/csk-cli/main/scripts/install.sh | bash -s -- --version v0.1.0-alpha.1
```

### macOS / Linux — Homebrew

```bash
brew tap eigentlab/csk-cli https://github.com/EIgentLab/csk-cli
brew install csk
```

Or in one line:

```bash
brew install eigentlab/csk-cli/csk
```

### Windows — Scoop

```powershell
scoop bucket add eigentlab https://github.com/EIgentLab/csk-cli
scoop install csk
```

### Manual download

Grab the binary for your platform from the [Releases](https://github.com/EIgentLab/csk-cli/releases) page.

| Platform | File pattern |
|---|---|
| Linux x86_64 | `csk_v*_Linux_x86_64.tar.gz` |
| Linux arm64 | `csk_v*_Linux_arm64.tar.gz` |
| macOS x86_64 | `csk_v*_Darwin_x86_64.tar.gz` |
| macOS arm64 (Apple Silicon) | `csk_v*_Darwin_arm64.tar.gz` |
| Windows x86_64 | `csk_v*_Windows_x86_64.zip` |

### Verify

```bash
csk version
```

---

## Quick Start

```bash
# 1. Install skills + agents into ./.claude/ (local project)
csk install

# 2. Install globally (~/.claude/) instead
csk install -g

# 3. See what was installed
csk list

# 4. Build deliverables index (required before search/viz)
csk db rebuild

# 5. Explore available skills
csk skills list
csk skills search "prd"
```

---

## Commands

### Install & Manage

| Command | Description | Key flags |
|---|---|---|
| `csk install` | Install embedded skills & agents to target directory | `-g` global, `--keep` preserve conflicts |
| `csk uninstall` | Remove all installed assets | `-g` global |
| `csk update` | Re-install if binary version differs from manifest | `-g` global, `--dry-run` preview only |
| `csk list` | Show installed skills & agents from manifest | `-g` global |
| `csk version` | Print binary version | — |

### Deliverables Index

| Command | Description | Key flags |
|---|---|---|
| `csk db rebuild` | Scan `deliverables/` → regenerate `artifacts.csv` + `refs.csv` | `-v` verbose |
| `csk db verify` | Validate index integrity (stale files, broken refs, bidirectional mismatches) | — |
| `csk db stats` | Print artifact & ref statistics | — |
| `csk db list` | List artifacts by phase, status, or project | `--phase P0-P6`, `--status`, `--project`, `--json` |

### Search & Lookup

| Command | Description | Key flags |
|---|---|---|
| `csk find <id>` | Look up artifact by ID — prints path + frontmatter | `--full` include body, `--json` |
| `csk refs <id>` | List cross-references for an artifact | `--in` incoming only, `--out` outgoing only, `--all` both, `--json` |
| `csk orphans` | List artifacts with no incoming or outgoing refs | `--exclude-type`, `--include-all`, `--json` |
| `csk broken-refs` | Validate all refs — checks stale files, broken targets, bidirectional mismatches | `--json` |
| `csk search "<query>"` | Ripgrep across deliverables with artifact annotations | `--type`, `--status`, `--limit`, `--case-sensitive`, `--json` |

### Skills Registry

| Command | Description | Key flags |
|---|---|---|
| `csk skills list` | Enumerate `.claude/skills/csk-*/SKILL.md` | `--phase P0-P6`, `--owner`, `--json` |
| `csk skills search "<query>"` | Rank skills by keyword + phase + owner relevance | `--phase`, `--owner`, `--limit`, `--json` |

### Visualization

| Command | Description | Key flags |
|---|---|---|
| `csk viz graph` | Generate Mermaid flowchart of artifact references | `--type` filter, `--out` write to file |
| `csk viz rtm` | Generate Mermaid Requirements Traceability Matrix diagram | `--type` filter, `--out` write to file |
| `csk viz trace <id>` | Generate Mermaid trace diagram from a single artifact | `--depth` max depth (0 = unlimited), `--out` write to file |
| `csk export` | Export deliverables index as HTML dashboard | `--html`, `--open` open in browser, `--out` path |

> **Deprecated aliases:** `csk graph` → `csk viz graph`, `csk rtm trace` → `csk viz trace`

### Watch Mode

| Command | Description | Key flags |
|---|---|---|
| `csk watch` | Monitor `deliverables/` for changes and auto-rebuild indexes | `-d` debounce ms (default 500), `-q` quiet |

---

## Workflow Guide

CSK CLI supports the **Inception-Driven Standard Agile** workflow — a 6-phase pipeline optimized for fixed-scope agency projects with teams of 8-10 people.

### Phase Pipeline

```
P0 Discovery → P1 Inception → P2 Definition+Design → P3 Planning → P4 Sprint Loop ◄─┐
                                                                          ▼              │
                                                                     P5 Release+UAT      │
                                                                          ▼              │
                                                                     P6 Maintenance ─────┘
```

### Commands by Phase

| Phase | Timebox | Key CSK Commands | Deliverables |
|---|---|---|---|
| **P0 — Discovery** | 3-5 days | `csk skills list --phase P0` | Personas, Journey Map, JTBD |
| **P1 — Inception** | 5 days | `csk skills list --phase P1` | Vision Board, Feature Catalog, Lean Canvas |
| **P2 — Definition & Design** | 5-7 days | `csk skills list --phase P2` → `csk db rebuild` | PRD, SRS, FSD, OpenAPI, ADR, C4 L2, Wireframe, ERD |
| **P3 — Planning** | 2-3 days | `csk viz rtm` → `csk db verify` | WBS, Roadmap, Sprint Backlog, RTM seed |
| **P4 — Sprint Loop** | 2 wk × N | `csk watch` + `csk db rebuild` + `csk orphans` | User Stories, Test Cases, Burndown, RTM updates |
| **P5 — Release & UAT** | 1-2 wk | `csk broken-refs` + `csk viz trace` | UAT Sign-off, Release Notes, Runbook |
| **P6 — Maintenance** | Continuous | `csk search` + `csk find` | Incident Reports, Patch Notes |

### Typical Workflow Session

```bash
# After creating deliverables in P2:
csk db rebuild                          # Index all new artifacts
csk db list --phase P2                  # Verify P2 deliverables exist
csk broken-refs                         # Catch any missing cross-refs

# Visualize the full artifact graph:
csk viz graph --out docs/artifact-graph.mmd
csk viz rtm --out docs/rtm-diagram.mmd

# Trace a specific requirement through the pipeline:
csk viz trace FEAT-001 --depth 3

# During sprints, keep index fresh:
csk watch                               # Auto-rebuild on every .md save

# Before release, validate everything:
csk db verify                            # Check for drift
csk orphans                              # Find disconnected artifacts
csk search "acceptance criteria"          // Quick content search
```

---

## Skills & Agents

### 10 Role-Based Agents

Installed to `.claude/agents/`:

| Agent | Role | Phase Ownership |
|---|---|---|
| `csk-po` | Product Owner | P1, P2, P4, P5 |
| `csk-pm` | Project Manager | P0, P3, P5, P6 |
| `csk-ba` | Business Analyst | P2, P4 |
| `csk-ux-ui` | UX/UI Designer | P0, P2 |
| `csk-architect` | Software Architect | P2 |
| `csk-tech-lead` | Tech Lead | P2, P4 |
| `csk-fullstack-dev` | Full-Stack Developer | P4 |
| `csk-qa` | QA Engineer | P2, P4, P5 |
| `csk-devops` | DevOps Engineer | P2, P4, P5, P6 |
| `csk-sm` | Scrum Master | P3, P4 |

### 36 Skills

Installed to `.claude/skills/` — each skill is a `csk-{artifact}/SKILL.md` with template, guidelines, and examples:

| Phase | Skills |
|---|---|
| **P0** | `csk-stakeholder-interview` · `csk-jtbd` · `csk-persona` · `csk-journey-map` · `csk-user-research` |
| **P1** | `csk-vision-board` · `csk-lean-canvas` · `csk-feature-catalog` |
| **P2** | `csk-prd` · `csk-srs` · `csk-fsd` · `csk-c4-l1` · `csk-c4-l2` · `csk-adr` · `csk-openapi` · `csk-erd` · `csk-wireframe` · `csk-wireflow` · `csk-design-system` · `csk-brand` · `csk-test-strategy` · `csk-test-plan` · `csk-test-cases` · `csk-rtm` |
| **P3** | `csk-wbs` · `csk-roadmap` · `csk-sprint-planning` · `csk-sprint-backlog` · `csk-raci` · `csk-risk-register` |
| **P4** | `csk-user-story` · `csk-bug-report` · `csk-validate` · `csk-revise` |
| **P5** | `csk-uat` |
| **Any** | `csk-conduct` (meta-router) · `csk-orchestrate` |

Browse available skills:

```bash
csk skills list                   # All skills
csk skills list --phase P2        # P2 Definition & Design only
csk skills list --owner architect # Architect-owned skills
csk skills search "test"          # Fuzzy search by keyword
```

---

## Deliverables Index

CSK CLI manages a structured deliverables directory with CSV-based indexing:

```
.project/deliverables/
├── _index/
│   ├── artifacts.csv       # id, type, version, status, path
│   └── refs.csv            # source_id, target_id, ref_type, source_file
├── p0-discovery/
│   ├── personas-v1.md
│   └── journey-map-v1.md
├── p1-inception/
│   ├── vision-board-v1.md
│   └── feature-catalog-v1.yaml
├── p2-definition/
│   ├── prd-v1.md
│   ├── srs-light-v1.md
│   ├── adr-001-postgresql.md
│   └── ...
└── ...
```

Each deliverable Markdown file uses CSK frontmatter:

```yaml
---
id: PRD-001
type: prd
version: "1.0"
status: approved
phase: P2
owners: [po]
upstream: [VISION-001, FCAT-001]
implements: [FEAT-001]
traces_to: [US-001, TC-001]
---

# Product Requirements Document
...
```

### Index Lifecycle

```bash
# After creating/editing deliverables:
csk db rebuild          # Regenerate artifacts.csv + refs.csv

# Continuous editing:
csk watch               # Auto-rebuild on file changes

# Validate integrity:
csk db verify            # Check stale, broken-refs, bidirectional mismatches
csk broken-refs          # Standalone broken-refs check
csk orphans              # Find disconnected artifacts
```

---

## Development

### Prerequisites

- Go 1.26.3+
- GoReleaser v2 (for releases)

### Build

```bash
make build              # Standard build
make garble             # Garble obfuscated build
make clean              # Remove artifacts
make release-snapshot   # Test GoReleaser locally
```

### Release Pipeline

1. Push a tag (`v*`) to `csk-cli`
2. GitHub Actions triggers GoReleaser
3. Binaries built for 5 platforms: `linux/amd64`, `linux/arm64`, `darwin/amd64`, `darwin/arm64`, `windows/amd64`
4. Releases + Homebrew formula + Scoop manifest cross-pushed to this repo (`csk-cli`)

### Project Structure

```
csk-cli/                          # This repo — distribution & installers
├── Formula/csk.rb                # Homebrew formula template
├── Bucket/csk.json               # Scoop manifest template
├── scripts/install.sh            # curl installer script
└── LICENSE
```

---

## License

BUSL-1.1 (Business Source License 1.1) — see [LICENSE](./LICENSE).