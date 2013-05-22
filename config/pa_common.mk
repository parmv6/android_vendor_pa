# Set audio
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Ring_Digital_02.ogg \
  ro.config.notification_sound=F1_New_SMS.ogg \
  ro.config.alarm_alert=Alarm_Beep_03.ogg

# Copy specific ROM files
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/GooManager.apk:system/app/GooManager.apk 

# init.d support
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/pa/prebuilt/common/etc/init.pa.rc:root/init.pa.rc \
    vendor/pa/prebuilt/common/etc/init.d/99complete:system/etc/init.d/99complete

# userinit support
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pa/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pa/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# APNs
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Bring in camera effects
#PRODUCT_COPY_FILES +=  \
#    vendor/pa/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
#    vendor/pa/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Bring in all video files
#$(call inherit-product, frameworks/base/data/videos/VideoPackage2.mk)

# Exclude prebuilt paprefs from builds if the flag is set
ifneq ($(PREFS_FROM_SOURCE),true)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk
else
    # Build paprefs from sources
    PRODUCT_PACKAGES += \
        ParanoidPreferences
endif

ifneq ($(PARANOID_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/$(PARANOID_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/XHDPI.zip:system/media/bootanimation.zip
endif

# T-Mobile theme engine
include vendor/pa/config/themes_common.mk

#Embed superuser into settings 
SUPERUSER_EMBEDDED := true

# device common prebuilts
ifneq ($(DEVICE_COMMON),)
    -include vendor/pa/prebuilt/$(DEVICE_COMMON)/prebuilt.mk
endif

# device specific prebuilts
-include vendor/pa/prebuilt/$(TARGET_PRODUCT)/prebuilt.mk

BOARD := $(subst pa_,,$(TARGET_PRODUCT))

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 5
PA_VERSION_MAINTENANCE = 5
PA_PREF_REVISION = 1

TARGET_CUSTOM_RELEASETOOL :=source vendor/pa/tools/squisher

VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
ifeq ($(DEVELOPER_VERSION),true)
    PA_VERSION := dev_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)
else
    PA_VERSION := $(TARGET_PRODUCT)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.modversion=$(PA_VERSION) \
  ro.pa.family=$(PA_CONF_SOURCE) \
  ro.pa.version=$(VERSION) \
  ro.papref.revision=$(PA_PREF_REVISION)

# Setup OTA with goo.im
PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.developerid=zeelog \
    ro.goo.board=blade \
    ro.goo.rom=pa3_blade \
    ro.goo.version=
