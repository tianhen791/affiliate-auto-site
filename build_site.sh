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

# commit
git add -A
git commit -m "Auto build $(date '+%Y-%m-%d %H:%M')" --allow-empty

# push with retry
for i in 1 2 3; do
    if git pull --rebase origin main 2>/dev/null && git push origin main 2>/dev/null; then
        echo "✅ Build & deploy complete: $(date)"
        exit 0
    fi
    echo "⚠️ Push attempt $i failed, retrying in 10s..."
    sleep 10
done

echo "❌ Push failed after 3 attempts. Site built locally but not deployed."
echo "   Run manually: cd $(pwd) && git pull --rebase origin main && git push origin main"
exit 1
