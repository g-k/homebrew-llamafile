cask "llamafile" do
  arch arm: "arm64"

  name "llamafile"
  version "0.8.17"
  sha256 arm: "8567e1c50aa509c4e63844ddbb934b096fa7cb71e52b75a38392d7caa01cae2b"
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
