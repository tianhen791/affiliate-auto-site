#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"
# generate links
python3 generate_links.py
# build site from Hugo directory
cd hugo_site
hugo --quiet
# copy built site back to repo root for GitHub Pages
cp -r public/* ../
cd ..
# commit & push
git add -A
git commit -m "Auto build $(date '+%Y-%m-%d %H:%M')" --allow-empty
git push origin main
echo "✅ Build & deploy complete: $(date)"
