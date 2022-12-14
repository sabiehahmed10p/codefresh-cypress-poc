# syntax=docker/dockerfile:experimental
FROM amazonlinux:2 as test-env

USER root

# Wanted to use amazon/aws-sam-cli-build-image-nodejs14.x
# but had some trouble installing cypress dependencies.
RUN yum install -q -y curl xorg-x11-server-Xvfb gtk2-devel gtk3-devel libnotify-devel \
  GConf2 nss libXScrnSaver alsa-lib procps zip unzip make shadow-utils \
  && curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
  && yum install -q -y nodejs && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install

WORKDIR /app

COPY package* /app/

RUN  npm install && npm audit fix

COPY . /app
