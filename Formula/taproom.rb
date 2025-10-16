class Taproom < Formula
  desc "Interactive TUI for Homebrew"
  homepage "https://github.com/hzqtc/taproom"
  url "https://github.com/hzqtc/taproom/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "311a7a3fb39cfbf478bd0a9ac2c6b5cc5fc509383edad223b119ec89f7ef66b5"
  license "MIT"
  head "https://github.com/hzqtc/taproom.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/slickag/stash"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "dc091b663bf444cf57656f6e000e25c1ea87e0dd9262900090a117b0943d233f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71edc255b70e3a018a2293d1709013aec3502b0ef90d34606e04e99f86cc8051"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    require "pty"
    require "expect"
    require "io/console"
    timeout = 30

    PTY.spawn("#{bin}/taproom --hide-columns Size") do |r, w, pid|
      r.winsize = [80, 130]
      begin
        refute_nil r.expect("Loading all Casks", timeout), "Expected cask loading message"
        w.write "q"
        r.read
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      ensure
        r.close
        w.close
        Process.wait(pid)
      end
    end
  end
end
