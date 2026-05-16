class Twilight < Formula
  desc "Menu-bar utility that switches macOS Light/Dark mode at sunrise/sunset"
  homepage "https://github.com/thegoatsmith/twilight"
  url "https://github.com/thegoatsmith/twilight/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "593282c0ee01609ad1500c95baca820f5b4b8941c9a1013783f2985dc980fb87"
  license "MIT"
  head "https://github.com/thegoatsmith/twilight.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on xcode: ["14.0", :build]
  depends_on "xcodegen" => :build
  depends_on macos: :ventura

  def install
    system "xcodegen", "generate"
    xcodebuild "-project", "Twilight.xcodeproj",
               "-scheme", "Twilight",
               "-configuration", "Release",
               "-derivedDataPath", "build",
               "MACOSX_DEPLOYMENT_TARGET=13.0"
    prefix.install "build/Build/Products/Release/Twilight.app"

    (bin/"twilight").write <<~SH
      #!/bin/sh
      exec /usr/bin/open "#{opt_prefix}/Twilight.app" "$@"
    SH
    (bin/"twilight").chmod 0755
  end

  def caveats
    <<~EOS
      Launch Twilight from the terminal with:
        twilight

      For Spotlight / Launchpad / Dock integration, symlink it once:
        ln -sfn #{opt_prefix}/Twilight.app /Applications/Twilight.app

      On first launch, grant Location and Automation (System Events) when prompted.
    EOS
  end

  test do
    assert_path_exists prefix/"Twilight.app/Contents/MacOS/Twilight"
    assert_path_exists bin/"twilight"
  end
end
