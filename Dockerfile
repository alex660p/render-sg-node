# Render 免费 Web Service（Docker 运行时）— sing-box VLESS+WS
# 平台在边缘终止 HTTPS，容器内只跑明文 WS（PaaS 常规玩法，与 Botkeep 节点同形态）
FROM alpine:3.20
ARG SB_VER=1.14.4
RUN apk add --no-cache ca-certificates curl tar \
 && ARCH=$(uname -m); case "$ARCH" in x86_64) A=amd64;; aarch64|arm64) A=arm64;; *) A=amd64;; esac \
 && curl -fsSL -o /tmp/sb.tgz "https://github.com/SagerNet/sing-box/releases/download/v${SB_VER}/sing-box-${SB_VER}-linux-${A}.tar.gz" \
 && tar xzf /tmp/sb.tgz -C /tmp \
 && install -m 0755 "/tmp/sing-box-${SB_VER}-linux-${A}/sing-box" /usr/local/bin/sing-box \
 && rm -rf /tmp/sb.tgz "/tmp/sing-box-${SB_VER}-linux-${A}"
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
