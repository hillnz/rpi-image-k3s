FROM jonoh/rpi-base:v0.0.10

# Pre-reqs, per https://rancher.com/docs/k3s/latest/en/advanced/#enabling-legacy-iptables-on-raspbian-buster
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy && \
    sed -i '$s/$/ cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# renovate: datasource=github-releases depName=k3s-io/k3s versioning=loose
ARG K3S_VERSION=v1.35.0+k3s3
# Hack so script knows it's a systemd system
RUN mkdir /run/systemd && \
    curl -sfL https://get.k3s.io | \    
        INSTALL_K3S_VERSION=${K3S_VERSION} \
        INSTALL_K3S_SKIP_ENABLE=true \
        K3S_TOKEN_FILE=/data/k3s/token \
        sh - && \
    systemctl enable k3s
