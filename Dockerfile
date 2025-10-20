FROM gitpod/openvscode-server:latest  

ENV OPENVSCODE_SERVER_ROOT="/home/.openvscode-server"  
ENV OPENVSCODE="${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server"  

USER root  

# 复制并安装插件  
COPY dolphindb-vscode-v3.0.405.vsix /tmp/plugin.vsix  
RUN ${OPENVSCODE} --install-extension /tmp/plugin.vsix  

# 创建并设置 workspace 目录权限  
RUN mkdir -p /workspace && \  
    chown -R openvscode-server:openvscode-server /workspace  

# 设置 entrypoint  
COPY entrypoint.sh /usr/local/bin/entrypoint.sh  
RUN chmod +x /usr/local/bin/entrypoint.sh  

RUN mkdir -p /home/workspace && \  
    chown -R openvscode-server:openvscode-server /home/workspace  

USER openvscode-server  

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]