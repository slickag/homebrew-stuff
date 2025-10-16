cask "parsec-startup" do
  version "150-100e"
  sha256 :no_check

  url "https://builds.parsecgaming.com/package/parsec-macos-startup.pkg",
      verified: "builds.parsecgaming.com/package/"
  name "Parsec"
  desc "Remote desktop (version with login screen access)"
  homepage "https://parsec.app/"

  livecheck do
    url "https://builds.parsec.app/channel/release/appdata/macos/latest"
    regex(/parsecd[._-]v?(\d+(?:[.-]\d+)+[a-z]*)\.dylib/i)
    strategy :json do |json, regex|
      json["so_name"]&.match(regex) { |match| match[1] }
    end
  end

  auto_updates true
  conflicts_with cask: "parsec"

  pkg "parsec-macos-startup.pkg"

  postflight do
    set_ownership "~/.parsec"
  end

  uninstall quit:    "tv.parsec.www",
            pkgutil: "tv.parsec.www"

  zap trash: [
    "/Library/LaunchAgents/com.parsec.app.plist",
    "~/.parsec",
    "~/Library/Caches/tv.parsec.www",
    "~/Library/HTTPStorages/tv.parsec.www",
    "~/Library/Preferences/tv.parsec.www.plist",
  ]
end
