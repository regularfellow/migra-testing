FROM mcr.microsoft.com/vscode/devcontainers/base:0-bullseye

# Python
RUN export DEBIAN_FRONTEND=noninteractive \
   && apt-get update && apt-get install -y postgresql-client \
      python3 python-is-python3 python3-pip python3-dev \
   && apt-get autoremove -y && apt-get clean -y

ARG USER=vscode

ARG WORKSPACE=/testing
WORKDIR ${WORKSPACE}
RUN chown -R ${USER}:${USER} ${WORKSPACE}

USER ${USER}
