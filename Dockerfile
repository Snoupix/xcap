# FROM alpine:latest
#
# RUN apk add --no-cache \
#     bash \
#     curl \
#     gcc \
#     g++ \
#     musl-dev \
#     make \
#     cmake \
#     pkgconfig \
#     pkgconf \
#     clang \
#     libxrandr-dev \
#     libxcb-dev \
#     dbus-dev \
#     pipewire-dev \
#     git \
#     llvm19-dev \
#     clang19-dev
#
# ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig
# # Ensures the lib exists
# RUN find /usr -name "libpipewire-0.3.pc"
# RUN pkg-config --libs --cflags libpipewire-0.3
#
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
#     source $HOME/.cargo/env && \
#     rustup target add \
#         x86_64-unknown-linux-gnu \
#         i686-unknown-linux-gnu
#
# RUN echo '/root/.cargo/bin/cargo $@' > /bin/cargo && chmod +x /bin/cargo
#
# ENV PATH="/root/.cargo/bin:$PATH"

FROM debian:12-slim

RUN apt update && \
    apt install bash curl gcc g++ make musl-dev cmake git pkg-config libclang-dev libxcb1-dev libxrandr-dev libdbus-1-dev libpipewire-0.3-dev -y
