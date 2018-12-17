#
# Copyright (C) 2017 The LineageOS Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Liquid.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
include vendor/liquid/config/common_full_phone.mk

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Device
$(call inherit-product, device/motorola/payton/device.mk)

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.qcom

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.qcom \
    libcutils \
    libgptutils \
    libz

# TWRP
ifeq ($(WITH_TWRP),true)
    $(call inherit-product, device/motorola/payton/twrp/twrp.mk)
else
    TARGET_RECOVERY_FSTAB := device/motorola/sdm660-common/rootdir/etc/fstab.qcom
endif

# Device identifiers
PRODUCT_DEVICE := payton
PRODUCT_NAME := liquid_payton
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto X4
PRODUCT_MANUFACTURER := Motorola
PRODUCT_RELEASE_NAME := payton

PRODUCT_BUILD_PROP_OVERRIDES += \
        PRODUCT_NAME=payton \
        PRIVATE_BUILD_DESC="motorola-user 9.0.0 PPW29.69-26 12 release-keys"

BUILD_FINGERPRINT := motorola/payton/payton:9.0.0/PPW29.69-26/12:user/release-keys