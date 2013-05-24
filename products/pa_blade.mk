# Copyright (C) 2012 ParanoidAndroid Project
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

# Check for target product
ifeq (pa_blade,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := HDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_blade

# Build paprefs from sources
PREFS_FROM_SOURCE ?= false

# Developer version
DEVELOPER_VERSION := true

# Include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# Inherit device configuration
$(call inherit-product, device/zte/blade/blade.mk)

# Product Package Extras - Repos can be added manually or via addprojects.py
-include vendor/pa/packages/skate.mk

# Override AOSP build properties
PRODUCT_NAME := pa_blade
PRODUCT_BRAND := ZTE
PRODUCT_MODEL := Blade
PRODUCT_MANUFACTURER := ZTE
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=blade BUILD_ID=JRO03C BUILD_FINGERPRINT=ZTE/N880E_JB4_2/atlas40:4.2/JOP40C/20121121.110335:user/release-keys PRIVATE_BUILD_DESC="N880E_JB4_2-user 4.2 JOP40C 20121121.110335 release-keys" BUILD_NUMBER=20121121.110335

# Update local_manifest.xml
#GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))
GET_PROJECT_RMS := $(shell vendor/pa/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pa/tools/addprojects.py $(PRODUCT_NAME))

endif
