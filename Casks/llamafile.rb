cask "llamafile" do
  arch arm: "arm64"

  name "llamafile"
  version "0.9.1"
  sha256 arm: "5b0fde0190a9c6b7c11c47757aaab7846c925d93e3174a3d8c8baff3c61c4bd9"
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
  binary "llamafile-#{version}/bin/localscore"
  binary "llamafile-#{version}/bin/whisperfile"
end
