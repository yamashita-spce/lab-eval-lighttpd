<!-- admin/Advanced_QoS.asp -->
<%-- ASP形式での例。実際の処理はサーバサイドで書き換えられることを想定 --%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>Advanced QoS設定</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <h1>QoS設定ページ (ASP形式)</h1>
  <form action="/cgi-bin/apply.cgi" method="POST">
    <p>
      <label>QoS有効/無効:
        <input type="checkbox" name="qos_enable" value="1" checked>有効
      </label>
    </p>
    <p>
      <label>上り帯域(kbps):
        <input type="number" name="upload_bw" value="2000">
      </label>
    </p>
    <p>
      <label>下り帯域(kbps):
        <input type="number" name="download_bw" value="5000">
      </label>
    </p>
    <input type="hidden" name="page_origin" value="Advanced_QoS">
    <button type="submit">設定を適用</button>
  </form>
  <p><a href="index.html">トップへ戻る</a></p>
</body>
</html>
