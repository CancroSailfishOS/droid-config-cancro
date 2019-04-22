# These and other macros are documented in
# ../droid-configs-device/droid-configs.inc
%define device cancro
%define vendor xiaomi
%define vendor_pretty Xiaomi
%define device_pretty Mi 3/Mi 4
%define dcd_path ./
# Adjust this for your device
%define pixel_ratio 2.0
# We assume most devices will
%define have_modem 1
# Community HW adaptations need this
%define community_adaptation 1
Provides: ofono-configs
%include droid-configs-device/droid-configs.inc
