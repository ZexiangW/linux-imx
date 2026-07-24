#!/usr/bin/env bash

set -euo pipefail

JOBS=8
DEFCONFIG=imx_xirang_defconfig
DTB_TARGET=nxp/imx/imx6ull-xirang.dtb
DTB_PATH="arch/arm/boot/dts/${DTB_TARGET}"
KERNEL_PATH="arch/arm/boot/zImage"
BOOT_IMG="boot.img"
KERNEL_CMDLINE=${KERNEL_CMDLINE:-"console=ttymxc0,115200 earlycon"}

if [[ "${ARCH:-}" != "arm" || -z "${CROSS_COMPILE:-}" ]]; then
	echo "Please source envsetup.sh before running build.sh" >&2
	exit 1
fi

make "${DEFCONFIG}"
make -j"${JOBS}" zImage "${DTB_TARGET}"

mkbootimg \
	--kernel "${KERNEL_PATH}" \
	--dtb "${DTB_PATH}" \
	--cmdline "${KERNEL_CMDLINE}" \
	--base 0x80000000 \
	--kernel_offset 0x00008000 \
	--tags_offset 0x00000100 \
	--pagesize 2048 \
	--header_version 2 \
	--output "${BOOT_IMG}"

echo "Created ${BOOT_IMG}"
