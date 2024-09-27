#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2024 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="fuxi"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export ALLOW_MISSING_DEPENDENCIES=true
	export OF_MAINTAINER="Adontoo"
	export OF_MAINTAINER_AVATAR="/tmp/misc/Adontoo.jpg"
	export OF_MAGISK="/tmp/misc/Magisk-v27.0.zip"
	export FOX_BUILD_TYPE="Beta"
	export FOX_USE_SPECIFIC_MAGISK_ZIP=/tmp/Magisk-v27.0.zip
	
	if [ -n "$OF_MAINTAINER_AVATAR" ]; then
        if [ ! -f "$OF_MAINTAINER_AVATAR" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAINTAINER_AVATAR\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              mkdir -p /tmp/misc
              curl https://github.com/adontoo/pixelos_manifest/blob/icon/snippets/icon.jpg >> $OF_MAINTAINER_AVATAR
              echo -e "${BLUE}-- Successfully Downloaded the Avatar Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Maintainer Avatar from the Downloaded Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${GREEN}-- Done!"
        fi
    fi
	
	if [ -n "$FOX_USE_SPECIFIC_MAGISK_ZIP" ]; then
    	if [ ! -f "$OF_MAGISK" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAGISK\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              wget -O /tmp/misc/Magisk-v27.0.zip https://github.com/topjohnwu/Magisk/releases/download/v27.0/Magisk-v27.0.apk
              echo -e "${BLUE}-- Successfully Downloaded the Magisk.zip File \"$OF_MAGISK\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Magisk.zip from the Downloaded file \"$OF_MAGISK\" ...${NC}"
              echo -e "${GREEN}-- Done!"
     	fi
    fi

	export LC_ALL="C"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export OF_USE_LZ4_COMPRESSION=1
	export OF_FLASHLIGHT_ENABLE=1
	export OF_SCREEN_H=2400
	export OF_STATUS_H=104
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1
	export OF_ALLOW_DISABLE_NAVBAR=1
	export OF_SUPPORT_VBMETA_AVB2_PATCHING=1
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	export OF_QUICK_BACKUP_LIST="/data;/boot;"
	export FOX_DELETE_AROMAFM=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_GREP_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_NANO_EDITOR=1
	export OF_FORCE_built_KERNEL=1
	export FOX_VIRTUAL_AB_DEVICE=1
	export OF_DYNAMIC_FULL_SIZE=9663676416
	export OF_DEFAULT_TIMEZONE="TAIST-8;TAIDT"
	export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1
	[ "$FOX_BUILD_TYPE" = "Stable" ] && export OF_ADVANCED_SECURITY=1;
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
