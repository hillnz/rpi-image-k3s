FROM jonoh/rpi-base:v0.0.8

# renovate: datasource=github-releases depName=k3s-io/k3s versioning=loose
ARG K3S_VERSION=v1.21.1+k3s1
# Hack so script knows it's a systemd system
RUN mkdir /run/systemd && \
    curl -sfL https://get.k3s.io | \    
        INSTALL_K3S_VERSION=${K3S_VERSION} \
        INSTALL_K3S_SKIP_ENABLE=true \
        sh - && \
    systemctl enable k3s
