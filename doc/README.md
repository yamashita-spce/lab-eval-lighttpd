# README

## 概要
このディレクトリは BusyBox + lighttpd を利用したIoT機器風の評価用Webサーバです。
静的HTML、CGI、Ajax、iframe、フレームセット、メタリフレッシュ、ログインフォーム、再起動処理など
各種ページ遷移を網羅するサンプルを配置しています。

## セットアップ
1. lighttpd をインストール
2. `cgi-bin/*.cgi` に対して実行権限を付与 (`chmod +x *.cgi`)
3. `conf/lighttpd.conf` の `server.document-root` を環境に合わせて書き換え
4. `run.sh` でサーバ起動 (または手動で `lighttpd -f conf/lighttpd.conf`)

## 利用方法
- ブラウザから `http://localhost:8080/` (ポート番号は conf に依存) にアクセス
- 各種リンクやフォーム送信、リロードなどを試し、アクセスログやエラーログを確認
- Fuzzer やクローラを当て、ページカバレッジを評価することも可能

## 注意
- 実機の設定操作は行いません (ダミー)。実運用には適しません。
- WebSocket実装は擬似です。実際にWS通信を行うには別途モジュールまたはプロキシが必要です。
