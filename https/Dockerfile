FROM openvscode-server-ddb:latest

USER root

# 安装 caddy 官方包
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list \
    && apt-get update && apt-get install -y caddy && apt-get clean

# 复制 Caddyfile + 启动脚本
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh

CMD ["/start.sh"]
