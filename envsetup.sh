#!/usr/bin/env bash

SDK_ENV="/opt/fsl-framebuffer/5.0-snapshot-20260716/environment-setup-cortexa7t2hf-neon-fsl-linux-gnueabi"

if [[ ! -f "$SDK_ENV" ]]; then
  echo "SDK environment not found: $SDK_ENV" >&2
  if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
    return 1
  fi
  exit 1
fi

# shellcheck disable=SC1090
source "$SDK_ENV"

export ARCH=arm
export CROSS_COMPILE="$TARGET_PREFIX"

# The Yocto SDK exports target compiler/sysroot flags via CC/CFLAGS/etc.
# U-Boot also builds host tools, so keep those tools on the native toolchain.
unset CC CXX CPP LD AS AR NM STRIP OBJCOPY OBJDUMP READELF
unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
unset PKG_CONFIG_SYSROOT_DIR PKG_CONFIG_PATH PKG_CONFIG_LIBDIR

export HOSTCC=gcc
export HOSTCXX=g++
export HOSTSTRIP=strip

echo "ARCH=$ARCH"
echo "CROSS_COMPILE=$CROSS_COMPILE"
echo "HOSTCC=$HOSTCC"
