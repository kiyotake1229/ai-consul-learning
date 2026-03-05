#!/bin/bash
# index.html の変更を検知して自動コミット＆プッシュ

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "👀 監視開始: $REPO_DIR/index.html"
echo "変更を検知するたびに GitHub へ自動プッシュします。Ctrl+C で停止。"
echo ""

fswatch -o "$REPO_DIR/index.html" | while read; do
  cd "$REPO_DIR"
  # 変更があれば
  if ! git diff --quiet index.html; then
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git add index.html
    git commit -m "auto: $TIMESTAMP"
    git push origin main
    echo "✅ [$TIMESTAMP] プッシュ完了"
  fi
done
