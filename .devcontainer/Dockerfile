FROM mcr.microsoft.com/devcontainers/ruby:3.3-bullseye

RUN apt update && \
    apt-get install --no-install-recommends -y \
    git \
    curl \
    wget \
    procps \
    net-tools \
    htop \
    strace \
    lsof && \
    unzip && \
    rm -rf /var/lib/apt/lists/*

# AWS CLI v2のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Solargraphのインストール
RUN su vscode -c "gem install solargraph"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"

# 作業ディレクトリの作成と権限設定
WORKDIR "/workspaces/infra-tools"
RUN chown vscode:vscode /workspaces/infra-tools
RUN bundle config set --local path vendor/bundle

# AWS認証情報ファイルのコピー
# COPY ./aws-config /home/vscode/.aws/config
# COPY ./aws-credentials /home/vscode/.aws/credentials

# ~/.aws ディレクトリの設定
RUN mkdir -p /home/vscode/.aws
RUN chown -R vscode:vscode /home/vscode/.aws