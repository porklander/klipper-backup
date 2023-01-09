#!/bin/bash

cd ~/klipper
#git pull

sudo service klipper stop


# Update head0
#echo "Start update SB2040"
#echo ""
#make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.sb2040
#make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.sb2040
#read -p "sb2040 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
#cd ~/CanBoot/scripts
#python3 flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u b3b97721329d
##read -p "sb2040 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
#echo "Finish update sb2040"
#echo ""

# Update mcu rpi
#echo "Start update mcu rpi"
#echo ""
#cd ~/klipper
#make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
#make KCONFIG=/home/pi/klipper_config/script/config.linux_mcu
#read -p "mcu rpi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
#sudo service klipper stop
#make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
#echo "Finish update mcu rpi"
#echo ""

# Update Octopus
echo "Start update Octopus"
echo ""
make clean
make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
#read -p "Octopus firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
cd ~/CanBoot/scripts
python3 flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ae6af168e91b
#read -p "EBB firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update Octopus"
echo ""

sudo service klipper start
