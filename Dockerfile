FROM codercom/code-server:latest

USER root

# 设置国内镜像源 (阿里云)
RUN echo "deb http://mirrors.aliyun.com/debian/ bookworm main contrib non-free non-free-firmware\n\
deb http://mirrors.aliyun.com/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
deb http://mirrors.aliyun.com/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
deb http://mirrors.aliyun.com/debian-security bookworm-security main contrib non-free non-free-firmware" \
    > /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y gosu && \
    rm -rf /var/lib/apt/lists/*
    
# 写 config.yaml
RUN mkdir -p /home/coder/.config/code-server && \
    cat <<EOF > /home/coder/.config/code-server/config.yaml
bind-addr: 0.0.0.0:3000
auth: none
cert: false
EOF

# 复制并安装 DolphinDB 插件
COPY dolphindb-vscode-v3.0.405.vsix /tmp/plugin.vsix
USER coder
RUN code-server --install-extension /tmp/plugin.vsix 
USER root
RUN rm /tmp/plugin.vsix

# 创建工作目录
RUN mkdir -p /workspace && \
    chown -R coder:coder /workspace

# 设置 entrypoint
COPY entrypoint-codeserver.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]