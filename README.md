# Code Server with DolphinDB Extension

这个项目提供了一个预配置了 DolphinDB 插件的 VS Code (code-server) Docker 环境。旨在方便开发者快速启动一个包含 DolphinDB 开发环境的云端 IDE。

## ✨ 特性

- **基于 code-server**: 使用 `codercom/code-server:latest` 作为基础镜像。
- **预装 DolphinDB 插件**: 内置 DolphinDB VS Code 插件 (v3.0.405)，开箱即用。
- **自动配置**: 容器启动时自动根据环境变量配置 DolphinDB 连接信息。
- **国内镜像优化**: 系统源已替换为阿里云镜像源，提高构建和安装速度。

## 🚀 快速开始

### 1. 构建镜像

使用提供的构建脚本构建 Docker 镜像：

```bash
./build.sh
```

或者手动执行 Docker build 命令：

```bash
docker build --no-cache -t codeserver-ddb:latest .
```

### 2. 运行容器

使用运行脚本启动容器：

```bash
./run.sh
```

或者使用以下命令手动启动：

```bash
docker run -it -d \
  -p 3003:3000 \
  -e DDB_HOST=183.134.101.139 \
  -e DDB_PORT=8892 \
  codeserver-ddb:latest
```

启动后，访问浏览器 `http://localhost:3003` 即可使用。

## ⚙️ 环境变量配置

可以通过设置以下环境变量来自动配置 VS Code 中的 DolphinDB 连接：

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| `DDB_HOST` | DolphinDB 服务器地址 | `127.0.0.1` |
| `DDB_PORT` | DolphinDB 服务器端口 | `8848` |
| `DDB_USER` | DolphinDB 用户名 | `admin` |
| `DDB_PASS` | DolphinDB 密码 | `123456` |
| `PORT` | code-server 监听端口 | `3000` |
| `PROXY_DOMAIN` | 代理域名配置 | `my.service.com` |

## 📂 项目结构

- `Dockerfile`: 主镜像构建文件。
- `entrypoint-codeserver.sh`: 容器启动脚本，负责生成配置文件和启动 code-server。
- `dolphindb-vscode-v3.0.405.vsix`: DolphinDB VS Code 插件安装包。
- `build.sh`: 构建脚本。
- `run.sh`: 运行脚本示例。
- `NarwhalEnv/`: (可选) 包含一个用于其他服务的 Python 环境 Docker 配置。

## 📝 注意事项

- 默认配置为无密码访问 (`auth: none`)，请确保在安全网络环境下运行或自行添加认证配置。
- 容器内部使用 `coder` 用户运行 code-server，工作目录挂载在 `/workspace`。
