#!/bin/bash
set -e

USER_CONFIG_DIR="/home/coder/.local/share/code-server/User"
mkdir -p "$USER_CONFIG_DIR"

# 动态生成 settings.json
cat > "$USER_CONFIG_DIR/settings.json" <<EOF
{
  "dolphindb.connections": [
    {
      "name": "localDDB",
      "url": "ws://${DDB_HOST:-127.0.0.1}:${DDB_PORT:-8848}",
      "autologin": true,
      "username": "${DDB_USER:-admin}",
      "password": "${DDB_PASS:-123456}"
    }
  ]
}
EOF

exec dumb-init code-server

