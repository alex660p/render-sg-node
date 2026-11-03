#!/bin/sh
# Render 节点启动脚本：sing-box VLESS+WS，监听平台分配的 $PORT。
set -e
PORT="${PORT:-10000}"
UUID="${SB_UUID:-ea8b112e-1673-4ed0-8dea-473b1763f006}"
WSPATH="${SB_PATH:-/aa722f85}"
cat > /tmp/config.json <<CFG
{
  "log": { "level": "info", "timestamp": true },
  "inbounds": [
    {
      "type": "vless",
      "tag": "vless-in",
      "listen": "0.0.0.0",
      "listen_port": ${PORT},
      "users": [ { "uuid": "${UUID}" } ],
      "transport": { "type": "ws", "path": "${WSPATH}" }
    }
  ],
  "outbounds": [ { "type": "direct", "tag": "direct" } ]
}
CFG
echo "starting sing-box on port ${PORT} ..."
exec sing-box run -c /tmp/config.json
