#!/usr/bin/env bash
set -euo pipefail

# csk install script
# Usage: curl -fsSL https://raw.githubusercontent.com/EIgentLab/csk-cli/main/scripts/install.sh | bash
# Or:    curl -fsSL https://raw.githubusercontent.com/EIgentLab/csk-cli/main/scripts/install.sh | bash -s -- --version v0.1.0-alpha.1

REPO="EIgentLab/csk-cli"
DEFAULT_INSTALL_DIR="${CSK_INSTALL_DIR:-$HOME/.local/bin}"

# --- Helpers ---
info()  { printf "\033[34m[INFO]\033[0m %s\n" "$1"; }
error() { printf "\033[31m[ERROR]\033[0m %s\n" "$1" >&2; }
warn()  { printf "\033[33m[WARN]\033[0m %s\n" "$1"; }

# --- Parse args ---
VERSION=""
INSTALL_DIR="$DEFAULT_INSTALL_DIR"
VERIFY_CHECKSUM=true
ADD_PATH=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --install-dir)
      INSTALL_DIR="$2"
      shift 2
      ;;
    --no-verify)
      VERIFY_CHECKSUM=false
      shift
      ;;
    --add-path)
      ADD_PATH=true
      shift
      ;;
    --help|-h)
      echo "Usage: install.sh [--version VERSION] [--install-dir DIR] [--no-verify] [--add-path]"
      echo ""
      echo "Options:"
      echo "  --version VERSION   Install specific version (default: latest)"
      echo "  --install-dir DIR   Install to DIR (default: ~/.local/bin)"
      echo "  --no-verify         Skip checksum verification"
      echo "  --add-path          Auto-add install dir to shell profile PATH"
      exit 0
      ;;
    *)
      error "Unknown option: $1"
      exit 1
      ;;
  esac
done

# --- Detect OS/Arch ---
detect_os() {
  local os
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  case "$os" in
    linux*) echo "Linux" ;;
    darwin*) echo "Darwin" ;;
    mingw*|cygwin*|msys*) echo "Windows" ;;
    *) echo "UNKNOWN" ;;
  esac
}

detect_arch() {
  local arch
  arch=$(uname -m)
  case "$arch" in
    x86_64|amd64) echo "x86_64" ;;
    arm64|aarch64) echo "arm64" ;;
    *) echo "UNKNOWN" ;;
  esac
}

OS=$(detect_os)
ARCH=$(detect_arch)

if [[ "$OS" == "UNKNOWN" ]]; then
  error "Unsupported OS: $(uname -s)"
  exit 1
fi
if [[ "$ARCH" == "UNKNOWN" ]]; then
  error "Unsupported architecture: $(uname -m)"
  exit 1
fi

# --- Resolve version ---
if [[ -z "$VERSION" ]]; then
  info "Fetching latest release version..."
  if ! command -v curl >/dev/null 2>&1; then
    error "curl is required but not installed."
    exit 1
  fi
  if ! VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" 2>/dev/null | grep '"tag_name":' | head -1 | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/'); then
    error "Failed to fetch latest version. Check network connection."
    exit 1
  fi
  if [[ -z "$VERSION" ]]; then
    error "Failed to detect latest version from GitHub API."
    exit 1
  fi
fi
info "Installing csk $VERSION for $OS/$ARCH..."

# --- Build asset URL ---
# GitHub tags include a "v" prefix (e.g. v1.0.0) but asset filenames don't
VERSION_NUM="${VERSION#v}"
ASSET_NAME="csk_${VERSION_NUM}_${OS}_${ARCH}.tar.gz"
if [[ "$OS" == "Windows" ]]; then
  ASSET_NAME="csk_${VERSION_NUM}_${OS}_${ARCH}.zip"
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/$ASSET_NAME"
CHECKSUM_URL="https://github.com/$REPO/releases/download/$VERSION/checksums.txt"

# --- Download ---
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

info "Downloading $ASSET_NAME..."
if ! curl -fsSL -o "$TMP_DIR/$ASSET_NAME" "$DOWNLOAD_URL"; then
  error "Failed to download $ASSET_NAME. Version $VERSION may not exist for platform $OS/$ARCH."
  exit 1
fi

# --- Verify checksum ---
if [[ "$VERIFY_CHECKSUM" == true ]]; then
  info "Verifying checksum..."
  if ! curl -fsSL -o "$TMP_DIR/checksums.txt" "$CHECKSUM_URL"; then
    warn "Could not download checksums.txt. Skipping verification (use --no-verify to suppress this warning)."
  else
    EXPECTED=$(grep "${ASSET_NAME}$" "$TMP_DIR/checksums.txt" 2>/dev/null | awk '{print $1}' || true)
    if [[ -z "$EXPECTED" ]]; then
      warn "Checksum for $ASSET_NAME not found in checksums.txt. Skipping verification."
    else
      if ! command -v sha256sum >/dev/null 2>&1; then
        if command -v shasum >/dev/null 2>&1; then
          GOT=$(shasum -a 256 "$TMP_DIR/$ASSET_NAME" | awk '{print $1}')
        else
          warn "Neither sha256sum nor shasum available. Skipping verification."
        fi
      else
        GOT=$(sha256sum "$TMP_DIR/$ASSET_NAME" | awk '{print $1}')
      fi
      if [[ -n "${GOT:-}" && "$GOT" != "$EXPECTED" ]]; then
        error "Checksum verification failed!"
        error "  Expected: $EXPECTED"
        error "  Got:      $GOT"
        exit 1
      fi
      if [[ -n "${GOT:-}" ]]; then
        info "Checksum OK."
      fi
    fi
  fi
fi

# --- Extract ---
info "Extracting..."
cd "$TMP_DIR"
if [[ "$ASSET_NAME" == *.zip ]]; then
  unzip -q "$ASSET_NAME"
else
  tar -xzf "$ASSET_NAME"
fi

# --- Install binary ---
BINARY_NAME="csk"
if [[ "$OS" == "Windows" ]]; then
  BINARY_NAME="csk.exe"
fi

# Find the extracted binary (it may be in a subdir)
BINARY_PATH=$(find "$TMP_DIR" -name "$BINARY_NAME" -type f | head -n 1)
if [[ -z "$BINARY_PATH" ]]; then
  error "Could not find $BINARY_NAME in extracted archive."
  exit 1
fi

install_binary() {
  local src="$1"
  local dst="$2"
  mkdir -p "$INSTALL_DIR"
  cp "$src" "$dst"
  chmod +x "$dst"
}

check_path() {
  local dir="$1"
  case ":${PATH}:" in
    *:"$dir":*) return 0 ;;
  esac

  local shell_profile=""
  local path_line=""
  case "$SHELL" in
    */zsh)  shell_profile="$HOME/.zshrc" ;;
    */bash) shell_profile="$HOME/.bashrc" ;;
    */fish) shell_profile="$HOME/.config/fish/config.fish"
            path_line="set -gx PATH $dir \$PATH" ;;
    *)      shell_profile="$HOME/.profile" ;;
  esac

  if [[ -z "$path_line" ]]; then
    path_line="export PATH=\"$dir:\$PATH\""
  fi

  warn ""
  warn "$dir is not in your PATH."
  warn "Add this line to $shell_profile:"
  warn "  $path_line"
  warn ""
  warn "Then run: source $shell_profile"

  if [[ "$ADD_PATH" == "true" ]]; then
    if [[ "$SHELL" == */fish ]]; then
      mkdir -p "$HOME/.config/fish"
    fi
    if [[ ! -f "$shell_profile" ]]; then
      touch "$shell_profile"
    fi
    echo "$path_line" >> "$shell_profile"
    info "Added PATH entry to $shell_profile"
    info "Run: source $shell_profile"
  fi
}

install_binary "$BINARY_PATH" "$INSTALL_DIR/$BINARY_NAME"
check_path "$INSTALL_DIR"

info "csk $VERSION installed successfully to $INSTALL_DIR/$BINARY_NAME."
info "Run 'csk version' to verify."
