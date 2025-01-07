#!/bin/bash
set -euo pipefail

# Configuration
REPO="Mozilla-Ocho/llamafile"
FORMULA_PATH="Casks/llamafile.rb"
TEMP_DIR=$(mktemp -d)
CACHE_DIR="update-formula-cache"
trap 'rm -rf "${TEMP_DIR}"' EXIT


mkdir -p "${CACHE_DIR}"

get_cache_path() {
    local file=$1
    echo "${CACHE_DIR}/${file}"
}

download_or_cache() {
    local version=$1
    local file=$2
    local cache_path=$(get_cache_path "${file}")

    if [[ -f "${cache_path}" ]]; then
        echo "Using cached ${cache_path}"
        cp "${cache_path}" "${TEMP_DIR}/${file}"
    else
        echo "Downloading version ${version} of ${file}..."
        if gh release download "${version}" -R ${REPO} -p "${file}" -D "${TEMP_DIR}"; then
            cp "${TEMP_DIR}/${file}" "${cache_path}"
            echo "Cached ${cache_path}"
        else
            echo "Failed to download ${file}"
            return 1
        fi
    fi
    return 0
}

clean_cache() {
    echo "Cleaning cache directory ${CACHE_DIR}..."
    rm -rf "${CACHE_DIR}"/*
    echo "Cache cleaned"
}

if [[ "${1:-}" == "clean" ]]; then
    clean_cache
    brew untap --force g-k/homebrew-llamafile-test || true
    exit 0
fi

echo "Fetching latest release information..."
LATEST_VERSION=$(gh release list -R Mozilla-Ocho/llamafile --limit 1 --json tagName --jq '.[].tagName')
LAST_VERSION=$(gh release list -R Mozilla-Ocho/llamafile --limit 2 --json tagName --jq '.[1].tagName')
echo "Latest version: ${LATEST_VERSION}"
echo "Last version: ${LAST_VERSION}"

echo "Downloading assets to ${CACHE_DIR} or copying to ${TEMP_DIR}..."
download_or_cache "${LATEST_VERSION}" "llamafile-${LATEST_VERSION}.zip" && \
    ZIP_HASH=$(shasum -a 256 "${TEMP_DIR}/llamafile-${LATEST_VERSION}.zip" | awk '{print $1}')


echo "Updating formula with hashes..."
echo "llamafile-${LATEST_VERSION}.zip=${ZIP_HASH}"
sed -i '' \
    -e "s/${LAST_VERSION}/${LATEST_VERSION}/g" \
    -e "s/sha256 arm: \"[a-f0-9]*\"/sha256 arm: ${ZIP_HASH}/" \
    "${FORMULA_PATH}"
echo "Printing formula diff..."
git diff "${FORMULA_PATH}"

# Verify formula
# refs: https://github.com/orgs/Homebrew/discussions/4864#discussioncomment-7395133
echo "Verifying formula..."
brew tap-new g-k/homebrew-llamafile-test --no-git
mkdir -p $(brew --repository)/Library/Taps/g-k/homebrew-llamafile-test/Casks/
cp "${FORMULA_PATH}" $(brew --repository)/Library/Taps/g-k/homebrew-llamafile-test/Casks
# brew audit --online --strict --cask g-k/homebrew-llamafile-test/llamafile
brew untap g-k/homebrew-llamafile-test

# Create git commit
echo "Creating git commit..."
git add "${FORMULA_PATH}"
git commit -m "Update llamafile to ${LATEST_VERSION}"

echo "Done! Please review changes and push to repository."
echo "Users can install with:"
echo "brew install llamafile"
echo ""
echo "To clean the download cache, run: $0 clean"
