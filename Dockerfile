FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖及 uv 工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 Astral uv
RUN pip install --no-cache-dir uv

# 复制项目代码
COPY . /app/

# 安装项目依赖
RUN uv pip install --system .

# 暴露 SSE 服务端口（默认通常是 8000 或自定义端口，这里以 8000 为例）
EXPOSE 8000

# 默认启动命令：使用 SSE 传输协议
ENTRYPOINT ["ldap-mcp", "--transport", "sse"]
