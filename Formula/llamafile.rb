class Llamafile < Formula
  desc "Distribute and run LLMs with a single file"
  homepage "https://github.com/Mozilla-Ocho/llamafile"

  livecheck do
    url :url
    strategy :github_releases
  end

  option "with-extras", "Install additional binaries (whisperfile, sdfile, llamafiler, bench, zipalign)"

  depends_on arch: :arm64
  depends_on :macos

  if build.with? "extras"
    url "https://github.com/Mozilla-Ocho/llamafile/releases/download/0.8.17/llamafile-0.8.17.zip"
    sha256 "1041e05b2c254674e03c66052b1a6cf646e8b15ebd29a195c77fed92cac60d6b"
  else
    url "https://github.com/Mozilla-Ocho/llamafile/releases/download/0.8.17/llamafile-0.8.17"
    sha256 "1041e05b2c254674e03c66052b1a6cf646e8b15ebd29a195c77fed92cac60d6b"
  end

  def install
    if build.with? "extras"
      bin.install "llamafile-0.8.17" => "llamafile"
      bin.install "whisperfile-0.8.17" => "whisperfile"
      bin.install "sdfile-0.8.17" => "sdfile"
      bin.install "llamafiler-0.8.17" => "llamafiler"
      bin.install "llamafile-bench-0.8.17" => "llamafile-bench"
      bin.install "zipalign-0.8.17" => "zipalign"

      %w[llamafile whisperfile sdfile llamafiler llamafile-bench zipalign].each do |binary|
        system "chmod", "+x", "#{bin}/#{binary}"
      end
    else
      bin.install "llamafile-0.8.17" => "llamafile"
      system "chmod", "+x", "#{bin}/llamafile"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llamafile --version", 2)

    if build.with? "extras"
      %w[whisperfile sdfile llamafiler llamafile-bench zipalign].each do |binary|
        assert_match version.to_s, shell_output("#{bin}/#{binary} --version", 2)
      end
    end
  end
end
