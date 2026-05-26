# typed: false
# frozen_string_literal: true

class Csk < Formula
  desc "Claude Skills & Agents CLI"
  homepage "https://github.com/EIgentLab/csk-cli"
  version "VERSION_PLACEHOLDER"
  license "BUSL-1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/EIgentLab/csk-cli/releases/download/VERSION_PLACEHOLDER/csk_VERSION_PLACEHOLDER_Darwin_x86_64.tar.gz"
      sha256 "SHA256_DARWIN_AMD64_PLACEHOLDER"
    elsif Hardware::CPU.arm?
      url "https://github.com/EIgentLab/csk-cli/releases/download/VERSION_PLACEHOLDER/csk_VERSION_PLACEHOLDER_Darwin_arm64.tar.gz"
      sha256 "SHA256_DARWIN_ARM64_PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EIgentLab/csk-cli/releases/download/VERSION_PLACEHOLDER/csk_VERSION_PLACEHOLDER_Linux_x86_64.tar.gz"
      sha256 "SHA256_LINUX_AMD64_PLACEHOLDER"
    elsif Hardware::CPU.arm?
      url "https://github.com/EIgentLab/csk-cli/releases/download/VERSION_PLACEHOLDER/csk_VERSION_PLACEHOLDER_Linux_arm64.tar.gz"
      sha256 "SHA256_LINUX_ARM64_PLACEHOLDER"
    end
  end

  def install
    bin.install "csk"
  end

  test do
    system "#{bin}/csk", "version"
  end
end
