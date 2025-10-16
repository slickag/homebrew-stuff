cask "mediadownloader" do
  version "5.4.3"
  sha256 "2934113466c46c8681de6f177ef758a79230c7a0371caf50e983a8e056d6489f"

  url "https://github.com/mhogomchungu/media-downloader/releases/download/#{version}/MediaDownloaderQt6-#{version}.dmg"
  name "Media Downloader"
  desc "Qt/C++ front end to yt-dlp, youtube-dl, gallery-dl, and more"
  homepage "https://github.com/mhogomchungu/media-downloader"

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "MediaDownloader.app"

  zap trash: [
    "~/Library/Application Support/media-downloader",
    "~/Library/Preferences/org.MediaDownloader.gui.plist",
  ]
end
