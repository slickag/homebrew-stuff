class Rclone < Formula
  desc "Rsync for cloud storage"
  homepage "https://rclone.org/"
  url "https://github.com/rclone/rclone/archive/refs/tags/v1.71.1.tar.gz"
  sha256 "a3aa14e37047081f9770d7c58a0f13e665ed99600259884246b1884fc4b30b6c"
  license "MIT"
  head "https://github.com/rclone/rclone.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/slickag/stash"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "64bbe9ca179217e5da60db9080b5265e0f7e5db5678b3953fa61b4cbf01540a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "89d45601b32351aeba1bd08c1ff3e6eee3a399aedd07ca90089590aff471401a"
  end

  depends_on "go" => :build

  on_linux do
    depends_on "libfuse@2"
  end

  def install
    ENV["GOPATH"] = prefix.to_s
    ENV["GOBIN"] = bin.to_s
    ENV["GOMODCACHE"] = "#{HOMEBREW_CACHE}/go_mod_cache/pkg/mod"
    ENV["CGO_FLAGS"] = "-g -O3"
    args = ["GOTAGS=cmount"]
    system "make", *args
    man1.install "rclone.1"
    system bin/"rclone", "genautocomplete", "bash", "rclone.bash"
    system bin/"rclone", "genautocomplete", "zsh", "_rclone"
    system bin/"rclone", "genautocomplete", "fish", "rclone.fish"
    bash_completion.install "rclone.bash" => "rclone"
    zsh_completion.install "_rclone"
    fish_completion.install "rclone.fish"
  end

  test do
    (testpath/"file1.txt").write "Test!"
    system bin/"rclone", "copy", testpath/"file1.txt", testpath/"dist"
    assert_match File.read(testpath/"file1.txt"), File.read(testpath/"dist/file1.txt")
  end
end
