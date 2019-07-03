# Copyright 2019 The Rockstar Project
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

# Enable SIP+VoIP
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Include APN information
PRODUCT_COPY_FILES += vendor/rockstar/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Copy init file
PRODUCT_COPY_FILES += vendor/rockstar/prebuilt/root/init.rockstar.rc:root/init.rockstar.rc

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

export VENDOR := rockstar

# Build Snapdragon apps
PRODUCT_PACKAGES += \
    SnapdragonGallery \
    SnapdragonMusic

# Include support for GApps backup
PRODUCT_COPY_FILES += \
    vendor/rockstar/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/rockstar/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/rockstar/prebuilt/bin/50-backuptool.sh:system/addon.d/50-backuptool.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/rockstar/prebuilt/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/rockstar/prebuilt/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/rockstar/prebuilt/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/rockstar/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/rockstar/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/rockstar/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept


# Include vendor SEPolicy changes
include vendor/rockstar/sepolicy/sepolicy.mk

