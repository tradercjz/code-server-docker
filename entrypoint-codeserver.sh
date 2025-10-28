#!/bin/bash
set -e

echo "Starting code-server setup..."

# 配置目录
CONFIG_DIR="/home/coder/.local/share/code-server/User"
mkdir -p "$CONFIG_DIR"

# 生成 settings.json
cat > "$CONFIG_DIR/settings.json" <<EOF
{
  "dolphindb.connections": [
    {
      "name": "localDDB",
      "url": "ws://${DDB_HOST:-127.0.0.1}:${DDB_PORT:-8848}",
      "autologin": true,
      "username": "${DDB_USER:-admin}",
      "password": "${DDB_PASS:-123456}"
    }
  ],
  "extensions.autoUpdate": false,
  "extensions.autoCheckUpdates": false,
  "telemetry.telemetryLevel": "off",
  "workbench.enableExperiments": false
}
EOF

# 设置权限
chown -R coder:coder /workspace
chown -R coder:coder /home/coder

echo "Installed extensions:"
gosu coder code-server --list-extensions --show-versions

echo "Starting code-server on port ${PORT:-3000}..."

# 启动 code-server - 关键参数
exec gosu coder code-server \
  --bind-addr "0.0.0.0:${PORT:-3000}" \
  --auth none \
  --disable-telemetry \
  --disable-update-check \
  --proxy-domain "${PROXY_DOMAIN:-my.service.com}" \
  /workspace