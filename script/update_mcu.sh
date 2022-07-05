#!/bin/bash

yes | cp /home/pi/klipper_config/script/board_defs.py /home/pi/klipper/scripts/spi_flash/board_defs.py -iR
yes | cp /home/pi/klipper_config/script/ercf.py /home/pi/klipper/klippy/extras/ercf.py -iR
yes | cp /home/pi/klipper_config/script/exclude_object.py /home/pi/klipper/klippy/extras/exclude_object.py -iR
yes | cp /home/pi/klipper_config/script/tuning_tower.py /home/pi/klipper/klippy/extras/tuning_tower.py -iR
yes | cp /home/pi/klipper_config/script/virtual_sdcard.py /home/pi/klipper/klippy/extras/virtual_sdcard.py -iR

cd ~/klipper
#git pull

# Update head0
echo "Start update EBB"
echo ""
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ebb
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.ebb
read -p "EBB firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
cd ~/CanBoot/scripts
python3 flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ba51b493cff4
read -p "EBB firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update EBB"
echo ""

# Update mcu rpi
echo "Start update mcu rpi"
echo ""
cd ~/klipper
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
make KCONFIG=/home/pi/klipper_config/script/config.linux_mcu
read -p "mcu rpi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
sudo service klipper stop
make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
echo "Finish update mcu rpi"
echo ""

# Update mcu XYE
echo "Start update mcu XYE"
echo ""
make clean
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.skr_2_mcuXYEZ
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.skr_2_mcuXYEZ
read -p "mcu XYE firmware built, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_stm32f429xx_3A0047000250315637383220-if00 btt-skr-v2
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_stm32f429xx_3F0032001450305031353020-if00 btt-skr-v2
read -p "mcu XYE firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update mcu XYE"
echo ""


sudo shutdown now
#sudo service klipper start
