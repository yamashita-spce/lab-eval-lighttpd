#!/bin/sh
# cgi-bin/ws_server.cgi
# 実際のWebSocketではハンドシェイク等が必要になるが、
# ここではサンプルのためダミーのレスポンスを返すだけ
echo "Content-type: text/plain"
echo ""
echo "WebSocket server dummy. Real WS not implemented."
