FROM codercom/code-server:latest

COPY dolphindb-vscode-v3.0.405.vsix /tmp/plugin.vsix

# 写 config.yaml
RUN mkdir -p /home/coder/.config/code-server && \
    cat <<EOF > /home/coder/.config/code-server/config.yaml
bind-addr: 0.0.0.0:8080
auth: none
cert: false
EOF

# 安装 DolphinDB 插件（假设插件 ID 正确）
RUN  code-server --install-extension /tmp/plugin.vsix

USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER coder

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

