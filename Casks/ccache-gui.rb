cask "ccache-gui" do
  version "0.1.12"
  sha256 "7ca70c63db56ba3ac0c605683eca4d1f17c171c70e2542821e0b9286866e2548"

  url "https://github.com/macmade/ccache-gui/releases/download/#{version}/ccache.app.zip"
  name "CCache GUI"
  desc "GUI helper for ccache"
  homepage "https://github.com/macmade/ccache-gui"

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "ccache.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.xs-labs.ccache.sfl*",
    "~/Library/Caches/com.xs-labs.ccache",
    "~/Library/HTTPStorages/com.xs-labs.ccache",
  ]
end
