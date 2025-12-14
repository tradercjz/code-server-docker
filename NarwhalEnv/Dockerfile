FROM python:3.13.11-slim

RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's|security.debian.org/debian-security|mirrors.tuna.tsinghua.edu.cn/debian-security|g' /etc/apt/sources.list.d/debian.sources


RUN apt-get update && apt-get install -y \
    dnsutils \
    iputils-ping \
    curl \
    netcat-openbsd \
    && apt-get clean

COPY helm /usr/local/bin/helm
# 赋予执行权限 
RUN chmod +x /usr/local/bin/helm

WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 🌟 预先初始化 DuckDB 并下载 vss 扩展
RUN python3 -c "\
import duckdb; \
conn = duckdb.connect(':memory:'); \
conn.execute('INSTALL vss'); \
conn.execute('LOAD vss'); \
conn.close(); \
print('VSS extension downloaded successfully')"

EXPOSE 8000