#!/bin/bash

#yes | cp /home/pi/klipper_config/script/ercf.py /home/pi/klipper/klippy/extras/ercf.py -iR

cd ~/klipper
#git pull

sudo service klipper stop


# Update head0
echo "Start update EBB"
echo ""
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ebb
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ebb
#read -p "EBB firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
cd ~/CanBoot/scripts
python3 flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 6281f291f6c4
#read -p "EBB firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update EBB"
echo ""

# Update mcu rpi
echo "Start update mcu rpi"
echo ""
cd ~/klipper
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
make KCONFIG=/home/pi/klipper_config/script/config.linux_mcu
#read -p "mcu rpi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
sudo service klipper stop
make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
echo "Finish update mcu rpi"
echo ""

# Update Octopus
echo "Start update Octopus"
echo ""
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.octopus
#read -p "Octopus firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
cd ~/CanBoot/scripts
python3 flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ae6af168e91b
#read -p "EBB firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update Octopus"
echo ""

sudo service klipper start
