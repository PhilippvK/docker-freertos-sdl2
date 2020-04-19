FROM ubuntu:14.04

MAINTAINER Philipp van Kempen "philipp.van-kempen@tum.de"

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get -yqq update && \
  apt-get install -yqq --no-install-recommends \
    git \
    make \
    g++ \
    gdb \
    gdbserver \
    wget \
    vim \
    dbus \
    astyle \
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
  rm -rf /var/lib/apt/lists/* /tmp/*

RUN  cd /tmp &&\
  VERSION=3.16 &&\
  BUILD=5 &&\
  wget -q https://cmake.org/files/v$VERSION/cmake-$VERSION.$BUILD-Linux-x86_64.sh &&\
  mkdir /opt/cmake &&\
  sh cmake-$VERSION.$BUILD-Linux-x86_64.sh --prefix=/opt/cmake --skip-license --exclude-subdir &&\
  ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake &&\
  rm cmake-$VERSION.$BUILD-Linux-x86_64.sh

RUN cd /tmp &&\
  echo "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-4.0 main" > /etc/apt/sources.list.d/llvm-4.0.list &&\
  wget -q -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - -q &&\
  apt-get update -yqq &&\
  apt-get install -yqq --no-install-recommends \
    clang-4.0 clang-tidy-4.0 --no-install-recommends &&\
  apt-get -yqq autoremove && apt-get -yqq autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/*

#RUN useradd -ms /bin/bash develop
#RUN echo "develop   ALL=(ALL:ALL) ALL" >> /etc/sudoers

RUN echo "set auto-load safe-path /" > ~/.gdbinit

#USER develop
#WORKDIR /home/develop
#RUN git clone https://github.com/google/googletest.git

# for gdbserver
EXPOSE 2000
