# CSK CLI

> Claude Skills & Agents CLI — install, manage, and use CSK skills and agents for Claude Code.

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

| Platform | Binary |
|---|---|
| Linux x86_64 | `csk_v*_Linux_x86_64.tar.gz` |
| Linux arm64 | `csk_v*_Linux_arm64.tar.gz` |
| macOS x86_64 | `csk_v*_Darwin_x86_64.tar.gz` |
| macOS arm64 | `csk_v*_Darwin_arm64.tar.gz` |
| Windows x86_64 | `csk_v*_Windows_x86_64.zip` |

## Verify

```bash
csk version
```

## Quick start

```bash
csk install          # Install skills/agents to ./.claude/
csk list             # Show installed items
csk db rebuild       # Rebuild CSV index
csk skills list      # List available skills
csk skills search    # Search skills by name or description
```

## License

BUSL-1.1 (Business Source License 1.1)
