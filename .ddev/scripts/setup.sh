#!/bin/bash

# Drupal CMS 自動セットアップスクリプト
# post-start hook で実行される

LOCK_FILE="/var/www/html/.ddev/.setup_done"
DB_SNAPSHOT="/var/www/html/.ddev/db_snapshots/initial.sql.gz"

# 既にセットアップ済みの場合はスキップ
if [ -f "$LOCK_FILE" ]; then
  echo "Setup already completed. Skipping..."
  exit 0
fi

echo "========================================"
echo "Drupal CMS 2.0 セットアップ"
echo "========================================"

cd /var/www/html

# Drupalがインストール済みか確認
if drush status bootstrap 2>/dev/null | grep -q "Successful"; then
  echo "Drupal is already installed."
else
  # データベーススナップショットがある場合はインポート
  if [ -f "$DB_SNAPSHOT" ]; then
    echo "Importing database snapshot..."
    gunzip -c "$DB_SNAPSHOT" | mysql -u db -pdb db
    echo "Database imported successfully."
  else
    echo ""
    echo "Drupal CMSは未インストールです。"
    echo "ウェブインストーラーを使用してインストールしてください:"
    echo ""
    echo "  https://drupal-cms.ddev.site"
    echo ""
    exit 0
  fi
fi

# 日本語翻訳の更新
echo "Updating Japanese translations..."
drush locale:check 2>/dev/null || true
drush locale:update 2>/dev/null || true

# カスタムテーマの有効化（存在する場合）
CUSTOM_THEME_PATH="/var/www/html/web/themes/custom/my_theme"
if [ -d "$CUSTOM_THEME_PATH" ]; then
  if ! drush pm:list --status=enabled 2>/dev/null | grep -q "my_theme"; then
    echo "Enabling custom theme: my_theme"
    drush theme:enable my_theme -y 2>/dev/null || true
  fi
fi

# キャッシュクリア
echo "Clearing cache..."
drush cache:rebuild

# セットアップ完了フラグを作成
touch "$LOCK_FILE"

echo "========================================"
echo "セットアップ完了!"
echo "サイトURL: https://drupal-cms.ddev.site"
echo "管理者: admin / admin"
echo "========================================"
