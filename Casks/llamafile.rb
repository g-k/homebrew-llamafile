cask "llamafile" do
  arch arm: "arm64"

  name "llamafile"
  version "0.9.0"
  sha256 arm: "a2d6877a19ebd33f593c9bb48663cba351d355d2c633e3676e826caa0b66cabf"
  url "https://github.com/Mozilla-Ocho/llamafile/releases/download/#{version}/llamafile-#{version}.zip"
  desc "Distribute and run LLMs with a single file"
  homepage "https://github.com/Mozilla-Ocho/llamafile"

  livecheck do
    url :url
    strategy :github_releases
  end

  binary "llamafile-#{version}/bin/llamafile"
  binary "llamafile-#{version}/bin/llamafile-bench"
  binary "llamafile-#{version}/bin/llamafile-convert"
  binary "llamafile-#{version}/bin/llamafile-imatrix"
  binary "llamafile-#{version}/bin/llamafile-perplexity"
  binary "llamafile-#{version}/bin/llamafile-quantize"
  binary "llamafile-#{version}/bin/llamafile-tokenize"
  binary "llamafile-#{version}/bin/llamafile-upgrade-engine"
  binary "llamafile-#{version}/bin/llamafiler"
  binary "llamafile-#{version}/bin/whisperfile"
end
