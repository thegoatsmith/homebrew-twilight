class Twilight < Formula
  desc "Menu-bar utility that switches macOS Light/Dark mode at sunrise/sunset"
  homepage "https://github.com/thegoatsmith/twilight"
  url "https://github.com/thegoatsmith/twilight/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "dcc7c578f96290ed91db74896d1ad4180740633cc713cf1ea13b5299c99b38ec"
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

  def post_install
    app_link = Pathname.new("/Applications/Twilight.app")
    app_target = opt_prefix/"Twilight.app"

    if app_link.symlink?
      return if app_link.readlink == app_target

      opoo "/Applications/Twilight.app points elsewhere; not modifying."
      return
    end

    if app_link.exist?
      opoo "/Applications/Twilight.app already exists; not modifying."
      return
    end

    begin
      ln_sf app_target, app_link
    rescue Errno::EACCES
      opoo "Could not write to /Applications. Run manually:\n  ln -sfn #{app_target} /Applications/Twilight.app"
    end
  end

  def caveats
    <<~EOS
      Twilight has been linked to /Applications. Launch it with:
        open -a Twilight
      Or from Spotlight / Launchpad.

      On first launch, grant Location and Automation (System Events) when prompted.
    EOS
  end

  test do
    assert_path_exists prefix/"Twilight.app/Contents/MacOS/Twilight"
  end
end
