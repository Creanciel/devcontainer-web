FROM debian:trixie-slim

ARG USER_UID=1000
ARG USER_GID=1000
ARG USERNAME=development

ENV HOME="/home/$USERNAME"

ARG NODE_VERSION=24.15.0
ARG PNPM_VERSION=latest

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    git \
    locales \
    make \
    sudo \
    uuid-dev \
    wget \
    xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

RUN groupadd --gid "$USER_GID" "$USERNAME" && \
    useradd --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME" && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"

USER "$USERNAME"
WORKDIR "$HOME"

RUN curl -fsSL https://mise.run | sh && \
    printf '# For mise (https://mise.jdx.dev/)\neval "$(~/.local/bin/mise activate bash)"\n' >> ~/.bash_aliases

RUN ~/.local/bin/mise use -g "node@$NODE_VERSION" && \
    ~/.local/bin/mise use -g "pnpm@$PNPM_VERSION"

RUN curl -fsSL https://vite.plus | bash && \
    printf '# Vite+ bin (https://viteplus.dev)\n. "$HOME/.vite-plus/env"\n' >> ~/.bash_aliases
