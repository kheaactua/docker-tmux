ARG UBUNTU_TAG=18.04
FROM ubuntu:${UBUNTU_TAG}

RUN apt-get -q -y update                      \
    && apt-get install -q -y                  \
        build-essential                       \
        autoconf automake libtool curl g++    \
        make gcc libevent-dev libncurses5-dev \
        git xsel pkg-config bison             \
    && apt-get -q -y autoremove               \
    && apt-get -q -y clean

LABEL                                                             \
  org.label-schema.description="tmux"                             \
  org.label-schema.name="tmux"                                    \
  org.label-schema.schema-version="1.0"                           \
  org.label-schema.url="https://github.com/kheaactua/docker-tmux" \
  org.label-schema.vendor="Matthew Russell"                       \
  org.label-schema.version="0.6"

ARG INSTALL_PREFIX=/usr/local
ENV INSTALL_PREFIX=${INSTALL_PREFIX}

ARG TMUX_TAG=3.2
ENV TMUX_TAG=${TMUX_TAG}

WORKDIR /bin
COPY install_tmux.sh ./
RUN ["chmod", "+x", "install_tmux.sh"]
RUN ["./install_tmux.sh"]

RUN apt remove -qy                \
    build-essential               \
    autoconf automake libtool g++ \
    make gcc                      \
    pkg-config                    \
    && apt clean

ENTRYPOINT ["/usr/local/bin/tmux"]

# vim: ts=4 sw=4 expandtab ff=unix :
