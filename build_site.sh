#!/usr/bin/env bash
set -euo pipefail
cd $(dirname $(realpath $0))
# generate links
python3 generate_links.py
# build site
hugo --quiet
# commit & push
cd hugo_site
# copy public to repo root
cp -r public/* ../
cd ..
git add -A
git commit -m "Auto build $(date '+%Y-%m-%d %H:%M')"
# push GitHub
git push origin main
