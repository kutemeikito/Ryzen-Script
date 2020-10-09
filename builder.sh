#!/usr/bin/env bash
#
# Copyright (C) 2020 Edwiin Kusuma Jaya (MWG_Ryzen)
#
# Simple Local Kernel Build Script
#
# Configured for Redmi Note 8 / ginkgo custom kernel source
#
# Setup build env with akhilnarang/scripts repo
#
# Use this script on root of kernel directory

bold=$(tput bold)
normal=$(tput sgr0)

# Scrip option
while (( ${#} )); do
    case ${1} in
        "-Z"|"--zip") ZIP=true ;;
    esac
    shift
done

[[ -z ${ZIP} ]] && { echo "${bold}Gunakan -Z atau --zip Untuk Membuat Zip Kernel Installer${normal}"; }

# Clone toolchain
if ! [ -d "../toolchain" ]; then
    wget -O proton.tar.zst https://github.com/kdrag0n/proton-clang/archive/20200801.tar.gz
    mkdir -p ../toolchain/clang12.0
    sudo tar -I zstd -xvf proton.tar.zst -C ../toolchain/clang --strip-components=1
else
    echo "${bold}Folder Toolchain Sudah Tersedia, Tidak Perlu Di Clone${normal}"
fi

# ENV
CONFIG=vendor/ginkgo-perf_defconfig
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG="/home/ryzen/out-new/arch/arm64/boot/Image.gz-dtb"
export KBUILD_BUILD_USER="EdwiinKJ"
export KBUILD_BUILD_HOST="AMDRyzen"
export PATH="/home/ryzen/toolchain/nusantaraclang12/bin:$PATH"
export LD_LIBRARY_PATH="/home/ryzen/toolchain/nusantaraclang12/lib:$LD_LIBRARY_PATH"
export KBUILD_COMPILER_STRING="$(/home/ryzen/toolchain/nusantaraclang12/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"
export CROSS_COMPILE=/home/ryzen/gcc/aarch64-maestro/bin/aarch64-maestro-linux-gnu-
export CROSS_COMPILE_ARM32=/home/ryzen/gcc/arm-maestro/bin/arm-maestro-linux-gnueabi-
export out=/home/ryzen/out-new

# Functions
clang_build () {
    make -j4 O=$out \
                          ARCH=arm64 \
                          CC="clang" \
                          AR="llvm-ar" \
                          NM="llvm-nm" \
					      LD="ld.lld" \
			              AS="llvm-as" \
			              OBJCOPY="llvm-objcopy" \
			              OBJDUMP="llvm-objdump" \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE=$CROSS_COMPILE \
                          CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32
}

# Build kernel
make O=$out ARCH=arm64 $CONFIG > /dev/null
echo -e "${bold}Compiling with CLANG${normal}\n$KBUILD_COMPILER_STRING"
clang_build

if ! [ -a $KERN_IMG ]; then
    echo "${bold}Build error, Tolong Perbaiki Masalah Ini${normal}"
    exit 1
fi

[[ -z ${ZIP} ]] && { exit; }

# clone AnyKernel3
if ! [ -d "AnyKernel3" ]; then
    git clone https://github.com/kutemeikito/AnyKernel3
else
    echo "${bold}Direktori AnyKernel3 Sudah Ada, Tidak Perlu di Clone${normal}"
fi

# ENV
ZIP_DIR=$KERNEL_DIR/AnyKernel3
VENDOR_MODULEDIR="$ZIP_DIR/modules/vendor/lib/modules"
STRIP="aarch64-linux-gnu-strip"

# Make zip
make -C "$ZIP_DIR" clean
wifi_modules
cp "$KERN_IMG" "$ZIP_DIR"/
make -C "$ZIP_DIR" normal
