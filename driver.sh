# Buka Directory
cd <ROM NAME>

#Device Tree, Vendor, Common, Kernel, And Tolchain
git clone -b 11.0 https://github.com/kutemeikito/device_xiaomi_trinket-common device/xiaomi/trinket-common
git clone -b 11.0 https://github.com/kutemeikito/device_xioami_ginkgo device/xiaomi/ginkgo
git clone -b 11.0 https://github.com/kutemeikito/vendor_xiaomi_trinket-common vendor/xiaomi/trinket-common
git clone -b 11.0 https://github.com/kutemeikito/android_vendor_ginkgo vendor/xiaomi/ginkgo
git clone https://github.com/kutemeikito/RastaMod69-Clang prebuilts/clang/host/linux-x86/clang-12.0
git clone -b NoWireguard https://github.com/kutemeikito/android_kernel_xiaomi_ginkgo kernel/xiaomi/ginkgo

# Hals
rm -rf hardware/qcom-caf/sm8150/display && rm -rf hardware/qcom-caf/sm8150/media && rm -rf hardware/qcom-caf/sm8150/audio
git clone https://github.com/xiaomi-sm6125/hardware_qcom-caf_sm8150_display.git hardware/qcom-caf/sm8150/display 
git clone https://github.com/xiaomi-ginkgo/android_hardware_qcom-caf_sm8150_media.git hardware/qcom-caf/sm8150/media 
git clone https://github.com/xiaomi-ginkgo/android_hardware_qcom-caf_sm8150_audio.git  hardware/qcom-caf/sm8150/audio
git clone https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wfd-commonsys -b LA.QSSI.11.0.r1-07100-qssi.0 vendor/qcom/opensource/commonsys-intf/wfd
