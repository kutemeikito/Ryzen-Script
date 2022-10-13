# UPSTREAM LINUX VERSION

- git remote add version https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git
- git fetch version <Kernel Version>
- git merge FETCH_HEAD --log=1000 --signoff
- git push
========================================================
# Merge CAF

- sudo git fetch https://source.codeaurora.org/quic/la/kernel/msm-4.9/ LA.UM.9.6.2.c25-02200-89xx.0 
- sudo git fetch https://source.codeaurora.org/quic/la/kernel/msm-4.14/  LA.UM.9.1.r1-11700-SMxxx0.0 
- git fetch https://android.googlesource.com/kernel/common android-4.14-stable
- git fetch https://android.googlesource.com/kernel/common upstream-linux-4.9.y

# F2fs Google

- git fetch https://android.googlesource.com/kernel/common upstream-f2fs-stable-linux-4.14.y

# Merge Codelinaro

- git fetch https://git.codelinaro.org/clo/la/kernel/msm-4.14 LA.UM.9.1.r1-12600.01-SMxxx0.QSSI13.0 
- git fetch https://git.codelinaro.org/clo/la/kernel/msm-4.9 LA.UM.10.6.2.r1-02500-89xx.0
- git fetch https://git.codelinaro.org/clo/la/kernel/common aosp-new/android-4.14-stable

- git merge FETCH_HEAD --log=100 --signoff
- sudo git push

========================================================

# Remote Ginkgo Drivers from CAF

- git remote add qcacld-3.0 https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0
- git remote add qca-wifi-host-cmn https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn
- git remote add fw-api https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/fw-api
- git remote add audio-kernel https://source.codeaurora.org/quic/la/platform/vendor/opensource/audio-kernel
- git remote add data-kernel https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/data-kernel

# Remote Ginkgo Drivers from codelinaro

- git remote add qcacld-3.0 https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0
- git remote add qca-wifi-host-cmn https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn
- git remote add fw-api https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api
- git remote add audio-kernel https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel
- git remote add data-kernel https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel

# Merge subtree

- git merge -X subtree=drivers/staging/qcacld-3.0 --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=drivers/staging/fw-api --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=drivers/staging/qca-wifi-host-cmn --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=techpack/audio --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=techpack/data --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=net/wireguard --log=1000 --signoff -S FETCH_HEAD

# Vince prima

- git remote add prima https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/prima
- git merge -X subtree=drivers/staging/prima --log=1000 --signoff FETCH_HEAD
==============================
# Initial merge:

- git fetch <Remote> <TAG>
- git merge -s ours --no-commit FETCH_HEAD --allow-unrelated-histories
- git read-tree --prefix=drivers/staging/qcacld-3.0 -u FETCH_HEAD
- git read-tree --prefix=drivers/staging/qca-wifi-host-cmn -u FETCH_HEAD
- git read-tree --prefix=drivers/staging/fw-api -u FETCH_HEAD
- git read-tree --prefix=techpack/audio -u FETCH_HEAD
- git read-tree --prefix=techpack/data -u FETCH_HEAD
- git commit
=============================

# Initial Kernel Source

- cherry-pick kayak biasa,
- Di source kernel 4.14 yang sudah ada, fetch dulu caf tag nya ..
- git fetch https://git.codelinaro.org/clo/la/kernel/msm-4.14 LA.UM.9.1.r1-11900-SMxxx0.0
- Kemudian lanjut di checkout
- git checkout FETCH_HEAD
- git checkout -b Android11
- Lanjut cherry-pick oem commit ..

# Vince Hals

- rm -rf hardware/qcom-caf/msm8996/display
- rm -rf hardware/qcom-caf/msm8996/media
- rm -rf hardware/qcom-caf/msm8996/audio
- rm -rf hardware/qcom-caf/wlan
- git clone git@github.com:PixelExperience/hardware_qcom-caf_msm8996_display -b twelve-LA.UM.9.6.2.r1-04100-89xx.0 hardware/qcom-caf/msm8996/display
- git clone git@github.com:PixelExperience/hardware_qcom-caf_msm8996_media -b twelve-LA.UM.9.6.2.r1-04100-89xx.0 hardware/qcom-caf/msm8996/media
- git clone git@github.com:PixelExperience/hardware_qcom-caf_msm8996_audio -b twelve-LA.UM.9.6.2.r1-04100-89xx.0 hardware/qcom-caf/msm8996/audio
- git clone git@gitlab.com:kutemeikito/rastamod69-clang.git prebuilts/clang/host/linux-x86/clang-rastamod
- git clone git@github.com:ThankYouMario/proprietary_vendor_qcom_sdclang.git -b ruby-12 prebuilts/clang/host/linux-x86/clang-sdllvm
- git clone git@github.com:kutemeikito/RastaMod69-Clang.git -b clang-12.0 prebuilts/clang/host/linux-x86/clang-rastamod
- git clone git@github.com:adnan-44/hardware_qcom-caf_wlan.git -b twelve hardware/qcom-caf/wlan
- git clone git@github.com:LineageOS/android_external_ant-wireless_antradio-library.git -b lineage-18.1 external/ant-wireless/antradio-library


# Ccache

- sudo mkdir /ccache 
- mkdir tempcc
- sudo umount /ccache
- sudo chmod 777 /ccache
- sudo mount --bind $PWD/tempcc /ccache
- export USE_CCACHE=1
- export CCACHE_EXEC=$(which ccache)
- export CCACHE_DIR=/ccache
- ccache -M 100G -F 0

- make xd -j$(nproc --all) | tee log.txt
- repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Codelinaro Hals

- https://git.codelinaro.org/clo/la/platform/hardware/qcom/display LA.UM.9.1.r1-11900-SMxxx0.0
- https://git.codelinaro.org/clo/la/platform/hardware/qcom/media LA.UM.9.1.r1-11900-SMxxx0.0
- https://git.codelinaro.org/clo/la/platform/hardware/qcom/audio LA.UM.9.1.r1-11900-SMxxx0.0


# Ginkgo Env setup Xdroid 13
- git clone git@github.com:kutemeikito/RastaMod69-Clang.git -b clang-12.0 prebuilts/clang/host/linux-x86/clang-rastamod
- git clone git@github.com:kutemeikito/android_kernel_xiaomi_ginkgo.git -b Thirteen kernel/xiaomi/ginkgo
- git clone git@github.com:kutemeikito/vendor_xiaomi_ginkgo.git vendor/xiaomi/ginkgo
- git clone git@github.com:kutemeikito/device_xiaomi_ginkgo.git -b xdroid-13.0 device/xiaomi/ginkgo
- git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera

# Ginkgo Env setup Ancient 12L

- git clone git@github.com:kutemeikito/RastaMod69-Clang.git -b clang-12.0 prebuilts/clang/host/linux-x86/clang-rastamod
- git clone git@github.com:kutemeikito/android_kernel_xiaomi_ginkgo.git -b Thirteen kernel/xiaomi/ginkgo
- git clone git@github.com:ancient-devices/vendor_xiaomi_ginkgo.git -b ancient-12.1 vendor/xiaomi/ginkgo
- git clone git@github.com:ancient-devices/device_xiaomi_ginkgo.git -b ancient-12.1 device/xiaomi/ginkgo
- git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera

# Ginkgo Env setup Ancient 13

- git clone git@github.com:kutemeikito/RastaMod69-Clang.git -b clang-12.0 prebuilts/clang/host/linux-x86/clang-rastamod
- git clone git@github.com:kutemeikito/android_kernel_xiaomi_ginkgo.git -b Thirteen kernel/xiaomi/ginkgo
- git clone git@github.com:ancient-devices/vendor_xiaomi_ginkgo.git -b ancient-13.0 vendor/xiaomi/ginkgo
- git clone git@github.com:ancient-devices/device_xiaomi_ginkgo.git -b ancient-13.0 device/xiaomi/ginkgo
- git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera

# XD GINKGO SETUP

- rm -rf f*/base
- rm -rf f*/av
- git clone https://github.com/Xdroid-Bump/xd_frameworks_av frameworks/av
- git clone https://github.com/Xdroid-Bump/xd_frameworks_base frameworks/base

# Ginkgo Hals Based Codelinaro

- rm -rf hardware/qcom-caf/sm8150/audio
- rm -rf hardware/qcom-caf/sm8150/media
- rm -rf hardware/qcom-caf/sm8150/display
- git clone git@github.com:kutemeikito/android_hardware_qcom_audio.git -b android-12.1 hardware/qcom-caf/sm8150/audio
- git clone git@github.com:kutemeikito/android_hardware_qcom_media.git -b android-12.1 hardware/qcom-caf/sm8150/media
- git clone git@github.com:kutemeikito/android_hardware_qcom_display.git -b android-12.1 hardware/qcom-caf/sm8150/display
