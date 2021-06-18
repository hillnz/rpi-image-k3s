FROM jonoh/rpi-base:v0.0.8

# renovate: datasource=github-releases depName=k3s-io/k3s versioning=loose
ARG K3S_VERSION=v1.21.1+k3s1
# Hack so script knows it's a systemd system
RUN mkdir /run/systemd && \
    curl -sfL https://get.k3s.io | \    
        INSTALL_K3S_VERSION=${K3S_VERSION} \
        INSTALL_K3S_SKIP_ENABLE=true \
        K3S_TOKEN_FILE=/data/k3s/token \
        sh - && \
    systemctl enable k3s

# renovate: datasource=github depName=docker/docker-install versioning=git
ARG DOCKER_INSTALL_VERSION=92cec076fa26ea5775946f05a1b6a5026a96e314
# renovate: datasource=github-releases depName=moby/moby
ARG DOCKER_VERSION=v20.10.7
RUN curl -sfL https://raw.githubusercontent.com/docker/docker-install/${DOCKER_INSTALL_VERSION}/install.sh | \
    VERSION=${DOCKER_VERSION} \
    sh -
