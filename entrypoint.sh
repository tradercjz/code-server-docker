#!/bin/bash  
set -e  
  
# OpenVSCode Server 的用户配置目录  
USER_CONFIG_DIR="/home/workspace/.openvscode-server/data/Machine"  
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
  
# 启动 OpenVSCode Server  
exec /home/.openvscode-server/bin/openvscode-server \
  --host 0.0.0.0 \
  --port ${PORT:-3000} \
  --without-connection-token \
  --default-folder /workspace