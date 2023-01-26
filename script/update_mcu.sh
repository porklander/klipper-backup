#!/bin/bash

cd ~/klipper
#git pull

sudo service klipper stop


# Update head0
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.head0
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.head0
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u b3b97721329d

# mcu ercf_selector(stm32f072xb)
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ercf_selector
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ercf_selector
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ba51b493cff4

# mcu ercf_gear(stm32g0b1xx)
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ercf_gear
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ercf_gear
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 8dfc54033d32


# Update mcu rpi
cd ~/klipper
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
make KCONFIG=/home/pi/klipper_config/script/config.linux_mcu
make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu


# Update Octopus
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
./scripts/flash-sdcard.sh /dev/ttyAMA0 btt-octopus-pro-f446-v1.0


sudo service klipper start
