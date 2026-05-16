class Twilight < Formula
  desc "Menu-bar utility that switches macOS Light/Dark mode at sunrise/sunset"
  homepage "https://github.com/thegoatsmith/twilight"
  url "https://github.com/thegoatsmith/twilight/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "dc6476d31049cf42ddc38e0df0d90fa35227f81ec062c02dc6c8d52cef431a2a"
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
  end

  def caveats
    <<~EOS
      Twilight is a .app bundle. To put it in /Applications:
        ln -sfn #{opt_prefix}/Twilight.app /Applications/Twilight.app

      Or copy it:
        cp -R #{opt_prefix}/Twilight.app /Applications/

      On first launch, grant Location and Automation (System Events) when prompted.
    EOS
  end

  test do
    assert_path_exists prefix/"Twilight.app/Contents/MacOS/Twilight"
  end
end
