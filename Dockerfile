FROM ubuntu:14.04

MAINTAINER Philipp van Kempen "philipp.van-kempen@tum.de"

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get -yqq update && \
  apt-get install -yqq --no-install-recommends \
    git \
    make \
    g++ \
    gdb \
    wget \
    vim \
    dbus \
    psmisc &&\
  apt-get install -yqq --no-install-recommends \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    libsdl2-2.0-0 \
    libsdl2-dev \
    libsdl2-image-2.0-0 \
    libsdl2-image-dev \
    libsdl2-gfx-dev \
    libsdl2-ttf-dev \
    libsdl2-mixer-dev &&\
  apt-get -yqq autoremove && apt-get -yqq autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* &&\
  cd /tmp &&\
  VERSION=3.16 &&\
  BUILD=5 &&\
  wget -q https://cmake.org/files/v$VERSION/cmake-$VERSION.$BUILD-Linux-x86_64.sh &&\
  mkdir /opt/cmake &&\
  sh cmake-$VERSION.$BUILD-Linux-x86_64.sh --prefix=/opt/cmake --skip-license --exclude-subdir &&\
  ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake &&\
  rm cmake-$VERSION.$BUILD-Linux-x86_64.sh &&\
  echo "set auto-load safe-path /" > ~/.gdbinit
