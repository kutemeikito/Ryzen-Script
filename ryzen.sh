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
    wget -O proton.tar.zst https://github.com/kdrag0n/proton-clang-build/releases/download/20200104/proton_clang-10.0.0-20200104.tar.zst
    mkdir -p ../toolchain/clang
    sudo tar -I zstd -xvf proton.tar.zst -C ../toolchain/clang --strip-components=1
else
    echo "${bold}Folder Toolchain Sudah Tersedia, Tidak Perlu Di Clone${normal}"
fi

# ENV
CONFIG=vendor/ginkgo-perf_defconfig
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG="$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb"
export KBUILD_BUILD_USER="EdwiinKJ"
export KBUILD_BUILD_HOST="Windows10Pro"
export PATH="$PARENT_DIR/toolchain/clang/bin:$PATH"
export LD_LIBRARY_PATH="$PARENT_DIR/toolchain/clang/lib:$LD_LIBRARY_PATH"
export KBUILD_COMPILER_STRING="$("$PARENT_DIR"/toolchain/clang/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"

# Functions
clang_build () {
    make -j$(nproc --all) O=out \
                          ARCH=arm64 \
                          CC="clang" \
                          AR="llvm-ar" \
                          NM="llvm-nm" \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi- 
}

# Build kernel
make O=out ARCH=arm64 $CONFIG > /dev/null
echo -e "${bold}Compiling with CLANG${normal}\n$KBUILD_COMPILER_STRING"
clang_build

if ! [ -a "$KERN_IMG" ]; then
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

# Functions
wifi_modules () {
    # credit @adekmaulana
    for MODULES in $(find "$KERNEL_DIR/out" -name '*.ko'); do
        "${STRIP}" --strip-unneeded --strip-debug "${MODULES}"
        "$KERNEL_DIR/out/scripts/sign-file" sha512 \
                "$KERNEL_DIR/out/certs/signing_key.pem" \
                "$KERNEL_DIR/out/certs/signing_key.x509" \
                "${MODULES}"
        case ${MODULES} in
                */wlan.ko)
            cp "${MODULES}" "${VENDOR_MODULEDIR}/qca_cld3_wlan.ko" ;;
        esac
    done
    echo -e "(i) Selesai Memindahkan wifi modules"
}

# Make zip
make -C "$ZIP_DIR" clean
wifi_modules
cp "$KERN_IMG" "$ZIP_DIR"/
make -C "$ZIP_DIR" normal
