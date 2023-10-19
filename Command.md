# UPSTREAM LINUX VERSION
```bash
- git remote add version https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git
- git fetch version <Kernel Version>
- git merge FETCH_HEAD --log=1000 --signoff
- git push
```

# F2fs Google
```bash
- git fetch https://android.googlesource.com/kernel/common upstream-f2fs-stable-linux-4.14.y
```

# Merge Codelinaro
```bash
- git fetch https://git.codelinaro.org/clo/la/kernel/msm-4.14 LA.UM.9.1.r1-14200.01-SMxxx0.QSSI14.0
- git fetch https://git.codelinaro.org/clo/la/kernel/common aosp-new/android-4.14-stable

- git merge FETCH_HEAD --log=1000 --signoff
- sudo git push
```

# Remote Ginkgo Drivers from codelinaro
```bash
- git remote add qcacld-3.0 https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0
- git remote add qca-wifi-host-cmn https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn
- git remote add fw-api https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api
- git remote add audio-kernel https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel
- git remote add data-kernel https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel
```

# Merge subtree
```bash
- git merge -X subtree=drivers/staging/qcacld-3.0 --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=drivers/staging/fw-api --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=drivers/staging/qca-wifi-host-cmn --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=techpack/audio --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=techpack/data --log=1000 --signoff -S FETCH_HEAD
- git merge -X subtree=net/wireguard --log=1000 --signoff -S FETCH_HEAD
```

# Initial merge:
```bash
- git fetch <Remote> <TAG>
- git merge -s ours --no-commit FETCH_HEAD --allow-unrelated-histories
- git read-tree --prefix=drivers/staging/qcacld-3.0 -u FETCH_HEAD
- git read-tree --prefix=drivers/staging/qca-wifi-host-cmn -u FETCH_HEAD
- git read-tree --prefix=drivers/staging/fw-api -u FETCH_HEAD
- git read-tree --prefix=techpack/audio -u FETCH_HEAD
- git read-tree --prefix=techpack/data -u FETCH_HEAD
- git commit
```

# Ccache
```bash
- sudo mkdir /ccache 
- mkdir tempcc
- sudo umount /ccache
- sudo chmod 777 /ccache
- sudo mount --bind $PWD/tempcc /ccache
- export USE_CCACHE=1
- export CCACHE_EXEC=$(which ccache)
- export CCACHE_DIR=/ccache
- ccache -M 100G -F 0
```

# Clown Build
```bash
- make clown -j$(nproc --all) | tee log.txt
- repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

## Ginkgo Env setup 
```bash
git clone git@github.com:kutemeikito/RastaMod69-Clang.git -b clang-12.0 prebuilts/clang/host/linux-x86/clang-rastamod
git clone git@github.com:kutemeikito/android_kernel_xiaomi_ginkgo.git kernel/xiaomi/ginkgo
git clone git@github.com:kutemeikito/vendor_xiaomi_ginkgo.git vendor/xiaomi/ginkgo
git clone git@github.com:kutemeikito/device_xiaomi_ginkgo.git device/xiaomi/ginkgo
git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera
```