#!/usr/bin/env bash
set -e

# Check if GIMP is installed
if ! command -v gimp >/dev/null 2>&1; then
    echo "GIMP is not installed. Please install GIMP first using your distribution's package manager."
    exit 1
fi

# Temporary directory for download and extraction
tmpdir="$(mktemp -d)"
zip="$tmpdir/photogimp.zip"

# Download latest PhotoGIMP release zip
curl -L --fail \
  https://github.com/Diolinux/PhotoGIMP/releases/latest/download/PhotoGIMP.zip \
  -o "$zip"

# Verify that the file is a zip
file "$zip" | grep -qi zip || {
  echo "Download failed: not a zip archive"
  exit 1
}

# Extract zip to temporary folder
unzip -q "$zip" -d "$tmpdir/photogimp"

# Define GIMP 3 configuration folder
cfg="$HOME/.config/GIMP/3.0"
mkdir -p "$cfg"

# Copy contents of PhotoGIMP 3.0 folder into GIMP config
cp -r "$tmpdir/photogimp/3.0/"* "$cfg/"

echo "PhotoGIMP installed. Restart GIMP to apply changes."
