#!/bin/sh
# cgi-bin/apply.cgi
# (chmod +x を忘れずに)
echo "Content-type: text/html"
# ここで実際には設定ファイル等を更新するロジックが走る想定

# とりあえずフォーム内容を受け取って表示 + リダイレクト

echo ""
echo "<html><body>"
echo "<h1>apply.cgi (設定適用ダミー)</h1>"
echo "<p>以下のPOSTデータを受け取りました:</p>"
echo "<pre>"

# POSTデータを全部標準入力から読み出して表示
cat -

echo "</pre>"

# 自動リダイレクトの例(HTML上のmeta refreshやJSでもよい)
echo "<p>3秒後に自動で結果ページに飛びます...</p>"
echo "<meta http-equiv=\"refresh\" content=\"3; url=/admin/apply_result.html\">"

echo "</body></html>"
