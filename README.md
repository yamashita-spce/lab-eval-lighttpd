# README

## 概要
本リポジトリは、BusyBox + lighttpd 環境で稼働する IoT 機器におけるページ遷移方式を網羅的にテストするための **評価用 Web サーバ** 一式です。  
ルーターや IP カメラ、NAS、スマートホーム機器などに見られる、多種多様なページ遷移パターン（リンク、フォーム送信、CGI リダイレクト、メタリフレッシュ、フレームセット、iframe、JavaScript/Ajax、WebSocket 風処理など）を簡易的に再現し、カバレッジ評価や Fuzzing を行う際のテストベースとして活用いただけます。

## ディレクトリ構成

```
evaluation_lighttpd/
 ├── admin/
 │    ├── index.html         # トップページ
 │    ├── Basic_WAN.htm      # WAN設定(静的HTML)
 │    ├── Advanced_QoS.asp   # QoS設定(ASP形式)
 │    ├── Rebooting.htm      # 再起動中画面
 │    ├── apply_result.html  # 設定適用結果ページ
 │    ├── frameset.html      # フレームセット例
 │    ├── iframe.html        # iframe例
 │    ├── meta_refresh.html  # メタリフレッシュ例
 │    ├── ws_example.html    # WebSocket / Ajax例
 │    ├── js/
 │    │    └── main.js       # 共通スクリプト
 │    ├── css/
 │    │    └── style.css     # スタイルシート
 │    └── images/
 │         └── placeholder.png
 ├── cgi-bin/
 │    ├── apply.cgi          # 設定適用用CGI (ダミー)
 │    ├── status.cgi         # ステータス取得用CGI (Ajax向け)
 │    ├── reboot.cgi         # 再起動処理のダミー
 │    ├── login.cgi          # ログイン処理のダミー
 │    └── ws_server.cgi      # WebSocket擬似サーバ (ダミー)
 ├── conf/
 │    └── lighttpd.conf      # lighttpd設定ファイル
 ├── logs/
 │    ├── access.log         # アクセスログ(空ファイル)
 │    └── error.log          # エラーログ(空ファイル)
 ├── doc/
 │    └── README.md          # 本ファイル
 └── run.sh                  # サーバ起動スクリプト
```

### 各ディレクトリの説明

- **admin/**  
  静的/動的ページやフロントエンドのリソースを格納します。  
  - HTML、ASP、CSS、JavaScript、画像などを配置し、ルーター風 UI を再現  
  - 多様な遷移方式（フレームセット、iframe、メタリフレッシュ など）をテストするための個別ページをサンプルとして用意

- **cgi-bin/**  
  設定変更やステータス取得などサーバー側ロジックを模擬する CGI スクリプト群を配置します。  
  - 実際にはダミー処理で、フォーム POST や Ajax リクエスト等を受け取り、その場で結果を表示したり HTML へリダイレクトするだけの機能

- **conf/**  
  lighttpd のメイン設定ファイル (lighttpd.conf) が入っています。  
  - ドキュメントルートの指定や CGI の設定など、起動に必要な設定を記述

- **logs/**  
  アクセスログやエラーログを保存するディレクトリです。  
  - 事前に空ファイルを置いていますが、実行環境に合わせてログ出力先を設定・編集してください

- **doc/**  
  リポジトリのドキュメントや解説用ファイルを格納します。  
  - この README も含まれています

- **run.sh**  
  lighttpd を起動する簡易スクリプトです。  
  - 環境に合わせてパスを修正し、`chmod +x run.sh` 後に `./run.sh` でサーバーを起動できます

## セットアップ手順

1. **依存パッケージの準備**  
   - BusyBox / lighttpd をインストール  
   - `lighttpd` 実行ファイルのパスを確認 (`which lighttpd` など)  

2. **ディレクトリの設置**  
   - 本リポジトリを `evaluation_lighttpd` ディレクトリ等の任意の場所に展開  
   - 必要に応じて `logs/`, `cgi-bin/` への書き込み権限を付与する  

3. **CGIスクリプトの実行権限付与**  
   ```bash
   chmod +x evaluation_lighttpd/cgi-bin/*.cgi
   ```

4. **lighttpd.conf のパス修正**  
   - `conf/lighttpd.conf` をエディタで開き、`server.document-root` などが実環境の絶対パスを指すように編集  
   - ログファイル (`error.log`, `access.log`) のパスや `cgi.assign` の設定なども環境に合わせて調整

5. **run.sh の起動**  
   ```bash
   cd evaluation_lighttpd
   chmod +x run.sh
   ./run.sh
   ```
   - 正常起動するとログファイルが `logs/` に出力され、`http://<サーバIP>:8080/` でアクセス可能になります

## 使い方

- **ブラウザでトップページ (`index.html`) を確認**  
  - 例: [http://localhost:8080/](http://localhost:8080/) にアクセス  
  - 各種リンクをクリックして静的ページ/ASPページ遷移を試す  
  - フォーム送信で `apply.cgi` が呼ばれ、ログにアクセスが記録されることを確認  
  - フレームセットや iframe で部分的なページ読み込みが行われる様子、メタリフレッシュによる自動リダイレクトなどを確認  
  - `ws_example.html` で Ajax (Fetch) ボタンを押す → `status.cgi` が呼ばれ、JSON っぽい文字列が返ってくる  

- **ログインフォーム**  
  - `index.html` のログインフォームを送信 → `login.cgi` へ POST  
  - 送信データが表示され、数秒後にトップへリダイレクトされる (ダミー認証)

- **設定適用 (apply.cgi)**  
  - WAN 設定 (`Basic_WAN.htm`) や QoS 設定 (`Advanced_QoS.asp`) 画面から設定を送信 → `apply.cgi`  
  - ダミー処理を行い、POST データの確認後に結果ページ (`apply_result.html`) へ転送

- **再起動テスト (reboot.cgi)**  
  - `reboot.cgi` にアクセスすると仮想的に再起動を行い、`Rebooting.htm` → `apply_result.html` と遷移

- **Fuzzer・クローラーの適用**  
  - これらのページ/CGI に対して自動化ツールや Fuzzer を使い、網羅的なアクセスを試みることで、  
    **「IoT機器が想定するページ遷移をすべてカバーできているか」** の確認に活用可能

## 注意事項
- 本プロジェクトはあくまで **「IoTデバイス風のページ遷移を網羅する」ためのダミーサーバ** です。  
  実際の機器設定を変更するわけではなく、セキュリティ等の考慮は最低限となっています。  
  テスト用途以外での利用は推奨しません。  
- WebSocket の実装は疑似的な例であり、リアルな双方向通信を行う場合は **mod_websocket** 等を使う必要があります。  
- ディレクトリ構成やファイル内容は自由に変更して構いません。ご利用環境に合わせて適宜修正してください。

## ライセンス
- 本サンプルコードはパブリックドメイン相当、または MIT ライセンス的に取り扱い可能です。  
  ご自由に改変・再配布いただけますが、自己責任でご利用ください。

## お問い合わせ
- 質問や不具合などがありましたら、Issue やプルリクエストでご連絡ください。  

以上で、**IoT機器風ページ遷移を網羅した評価用Webサーバ**のセットアップ＆利用ガイドとなります。  
Fuzzingや総合テストなどに是非活用ください。