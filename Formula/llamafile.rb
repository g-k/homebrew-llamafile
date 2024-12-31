class Llamafile < Formula
  desc "Distribute and run LLMs with a single file"
  homepage "https://github.com/Mozilla-Ocho/llamafile"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/Mozilla-Ocho/llamafile/releases/download/0.8.17/llamafile-0.8.17"
  sha256 "1041e05b2c254674e03c66052b1a6cf646e8b15ebd29a195c77fed92cac60d6b"

  def install
    system "chmod", "+x", "llamafile-0.8.17"
    bin.install "llamafile-0.8.17" => "llamafile"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llamafile --version", 2)
  end
end
