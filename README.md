# Drupal CMS 2.0 お試し環境

Drupal CMS 2.0 の機能をすぐに試せる開発環境です。
DDEV を使用して、ローカル環境で Drupal CMS 2.0 を体験できます。

## 必要な環境

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [DDEV](https://ddev.com/get-started/) v1.24 以上

## クイックスタート

```bash
# リポジトリをクローン
git clone <repository-url>
cd drupal-2.0-dev

# DDEV を起動（自動でセットアップが実行されます）
ddev start

# ブラウザでサイトを開く
ddev launch
```

これだけで Drupal CMS 2.0 が利用可能になります。

## アクセス情報

| 項目 | URL / 情報 |
|------|-----------|
| サイト | http://drupal-cms.ddev.site |
| 管理画面 | http://drupal-cms.ddev.site/admin |
| ユーザー名 | admin |
| パスワード | admin |
| Mailpit | http://drupal-cms.ddev.site:8025 |

## 有効化されている機能

### Drupal CMS 2.0 の主要機能

| 機能 | 説明 |
|------|------|
| **Drupal Canvas** | ビジュアルページビルダー |
| **Media Library** | メディア管理システム |
| **Content Moderation** | コンテンツワークフロー |
| **Scheduler** | 公開スケジュール管理 |
| **Linkit** | リンク挿入支援 |
| **CAPTCHA** | スパム対策 |
| **Easy Breadcrumb** | パンくずリスト |
| **Package Manager** | GUI でのモジュール管理 |

## プロジェクト構成

```
drupal-2.0-dev/
├── .ddev/
│   ├── config.yaml              # DDEV 設定（PHP 8.4, MySQL 8.0）
│   ├── scripts/setup.sh         # 自動セットアップスクリプト
│   └── db_snapshots/            # 初期データベース
├── frontend/                    # フロントエンド開発環境
│   ├── src/scss/                # SCSS ソース
│   ├── src/ts/                  # TypeScript ソース
│   ├── package.json             # npm 設定
│   └── webpack.config.js        # Webpack 設定
├── web/
│   └── themes/custom/my_theme/  # カスタムテーマ
├── composer.json
└── README.md
```

## フロントエンド開発

カスタムテーマの CSS/JS を編集する場合：

```bash
# 依存関係のインストール
cd frontend
npm install

# 開発モード（ファイル監視）
npm run dev

# 本番ビルド
npm run build

# Lint チェック
npm run lint

# フォーマット
npm run format
```

ビルドされたファイルは `web/themes/custom/my_theme/` に出力されます。

## よく使うコマンド

```bash
# DDEV 起動
ddev start

# DDEV 停止
ddev stop

# DDEV 再起動
ddev restart

# Drush コマンド実行
ddev drush <command>

# キャッシュクリア
ddev drush cache:rebuild

# Composer コマンド実行
ddev composer <command>

# データベースエクスポート
ddev export-db --gzip --file=backup.sql.gz

# データベースインポート
ddev import-db --file=backup.sql.gz

# SSH でコンテナに入る
ddev ssh
```

## カスタムテーマの有効化

```bash
# テーマを有効化
ddev drush theme:enable my_theme

# デフォルトテーマに設定
ddev drush config:set system.theme default my_theme -y

# キャッシュクリア
ddev drush cache:rebuild
```

## トラブルシューティング

### サイトにアクセスできない場合

```bash
# DDEV を完全に再起動
ddev poweroff
ddev start
```

### データベースをリセットしたい場合

```bash
# 初期状態に戻す
ddev import-db --file=.ddev/db_snapshots/initial.sql.gz
ddev drush cache:rebuild
```

### HTTPS で証明書エラーが出る場合

```bash
# mkcert をインストール（macOS）
brew install mkcert nss
mkcert -install
ddev restart
```

## ライセンス

Drupal CMS は [GNU General Public License, version 2 or later](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html) の下でライセンスされています。

## 参考リンク

- [Drupal CMS User Guide](https://project.pages.drupalcode.org/drupal_cms/)
- [Drupal User Guide](https://www.drupal.org/docs/user_guide/en/index.html)
- [DDEV Documentation](https://ddev.readthedocs.io/)
