#!/bin/bash
# 启动 OpenVSCode Server
/home/.openvscode-server/node /home/.openvscode-server/out/server-main.js \
    --host=127.0.0.1 \
    --port=3000 \
    --without-connection-token \
    --cors-origin='*' &

# 确保 Node 先启动
sleep 2

# 启动 Caddy
caddy run --config /etc/caddy/Caddyfile
