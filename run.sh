#!/bin/sh
# run.sh
# lighttpdを起動する簡単なスクリプト
# 実行前に chmod +x run.sh で実行権限を与える

LIGHTTPD_BIN=$(which lighttpd)
CONF_PATH="./conf/lighttpd.conf"

if [ ! -f "$CONF_PATH" ]; then
  echo "Configuration file not found: $CONF_PATH"
  exit 1
fi

echo "Starting lighttpd with config: $CONF_PATH"
$LIGHTTPD_BIN -f "$CONF_PATH"
