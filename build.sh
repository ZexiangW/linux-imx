#!/usr/bin/env bash

source /opt/fsl-framebuffer/5.0-snapshot-20260716/environment-setup-cortexa7t2hf-neon-fsl-linux-gnueabi

export ARCH=arm
export CROSS_COMPILE="$TARGET_PREFIX"

unset CC CXX CPP LD AS AR NM STRIP OBJCOPY OBJDUMP READELF
unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
unset PKG_CONFIG_SYSROOT_DIR PKG_CONFIG_PATH PKG_CONFIG_LIBDIR

export HOSTCC=gcc
export HOSTCXX=g++
export HOSTSTRIP=strip

make imx_xirang_defconfig
make zImage -j 8