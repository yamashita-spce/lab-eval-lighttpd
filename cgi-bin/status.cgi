#!/bin/sh
# cgi-bin/status.cgi
echo "Content-type: text/plain"
echo ""
echo "{"
echo "  \"status\": \"OK\","
echo "  \"uptime\": \"12345秒\","
echo "  \"connectedClients\": 4"
echo "}"
