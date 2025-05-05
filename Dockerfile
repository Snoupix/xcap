FROM rust:1.86

RUN dpkg --add-architecture i386

RUN apt update && apt install -y \
    bash \
    curl \
    gcc \
    g++ \
    make \
    cmake \
    git \
    llvm-dev \
    clang \
    pkg-config \
    libclang-dev \
    libxcb1-dev \
    libxrandr-dev \
    libdbus-1-dev \
    libpipewire-0.3-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32gcc-s1 \
    libxcb1-dev:i386 \
    libpipewire-0.3-dev:i386

ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig
ENV CROSS_CONTAINER_IN_CONTAINER=true
ENV PATH="/root/.cargo/bin:$PATH"

# Ensures the libs exists
RUN find /usr -name "libpipewire-0.3.pc"
RUN pkg-config --libs --cflags libpipewire-0.3
RUN find /usr -name "libpipewire*.so*" | grep i386
RUN find /usr -name "libxcb*.so*" | grep i386

RUN rustup target add \
    x86_64-unknown-linux-gnu \
    i686-unknown-linux-gnu
