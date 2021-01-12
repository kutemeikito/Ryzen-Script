# Buka Directory
cd CherishOS

#Hapus out
rm -rf out
# Use Cache
export USE_CCACHE=1
ccache -M 50G

# Build Rom
. build/envsetup.sh
export KBUILD_BUILD_USER="EdwiinKJ™"; export KBUILD_BUILD_HOST="RastaMod69"
brunch cherish_ginkgo-userdebug
