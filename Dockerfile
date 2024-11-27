FROM alpine:3.20.3

ARG VEGETA_VERSION=12.12.0
ARG TCPING_VERSION=2.6.0

# Docker image metadata in OCI annotations format
LABEL org.opencontainers.image.created="2024-11-15" \
      org.opencontainers.image.authors="Andrey Kropachev <andrey.kropachev@gmail.com>" \
      org.opencontainers.image.url="https://hub.docker.com/repository/docker/bsdelnik/service-image" \
      org.opencontainers.image.source="https://github.com/bsdelnik/service-docker-image" \
      org.opencontainers.image.version="0.5" \
      org.opencontainers.image.title="Service Image to use for debugging" \
      org.opencontainers.image.description="Service Image with useful utilities installed"

RUN apk add --no-cache \
        bash \
        busybox-extras \
        curl \
        bind-tools \
        git \
        iproute2-ss \
        jq \
        netcat-openbsd \ 
        nmap \
        postgresql-client \
        py3-pip \
        python3 \
        screen \
        tcpdump \
        tcpflow \
        vim \
        wget \
    && pip3 install --break-system-packages --upgrade pip \
    && pip3 install --break-system-packages --no-cache-dir \
        awscli boto3 \
    && wget https://github.com/tsenart/vegeta/releases/download/v${VEGETA_VERSION}/vegeta_${VEGETA_VERSION}_linux_amd64.tar.gz \
    && tar -xvzf vegeta_${VEGETA_VERSION}_linux_amd64.tar.gz \
    && mv vegeta /usr/local/bin/ \
    && rm vegeta_${VEGETA_VERSION}_linux_amd64.tar.gz \
    && wget https://github.com/pouriyajamshidi/tcping/releases/download/v${TCPING_VERSION}/tcping_Linux_static.tar.gz \
    && tar -xvzf tcping_Linux_static.tar.gz \
    && mv tcping /usr/local/bin/ \
    && rm tcping_Linux_static.tar.gz

COPY files/assume-role /bin/assume-role

ENTRYPOINT [ "/bin/bash" ]