## Manual Configuration

### Rotate the monitor (optional).
```bash
sudo bash -c "echo 'display_rotate=1' >> /boot/config.txt"
```

Other options:
* display_rotate=0 **Normal**
* display_rotate=1 **90 degrees**
* display_rotate=2 **180 degrees**
* display_rotate=3 **270 degrees**


### Improve the color depth.
```bash
sudo bash -c "echo 'framebuffer_depth=32' >> /boot/config.txt"
sudo bash -c "echo 'framebuffer_ignore_alpha=1' >> /boot/config.txt"
```

### Turn on font antialiasing for pretty text.
```bash
mkdir ~/.config/fontconfig
vi ~/.config/fontconfig/.fonts.conf
```
Paste the contents of the `src/fonts.xml` file and save.


### Prevent monitor sleep when it should be on.
```bash
sudo bash -c "echo 'xserver-command=X -s 0 dpms' >> /etc/lightdm/lightdm.conf"
```


### Start Chromium on startup and disable the cursor.

Install packages.
```bash
sudo apt-get update
wget -qO - http://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
echo "deb http://dl.bintray.com/kusti8/chromium-rpi jessie main" | sudo tee -a /etc/apt/sources.list
sudo apt-get install chromium-browser x11-xserver-utils unclutter

```

Add Chromium and Unclutter to the `autostart` file. If you want to change the 'homepage', modify `STARTUP_URL` below.
```bash
STARTUP_URL="https://danmconrad.github.io/daylight/?token=YOUR_TOKEN"

echo "@chromium-browser --start-fullscreen --disable-session-crashed-bubble --disable-infobars --kiosk $STARTUP_URL" >> ~/.config/lxsession/LXDE-pi/autostart
echo "@unclutter -idle 0.1 -root" >> ~/.config/lxsession/LXDE-pi/autostart
```


### HDMI control.

#### Option A: CEC Client

This option is great because it completely turns off the display, saving power, and precious lumens. Install [libcec](https://github.com/Pulse-Eight/libcec) by following the README for Raspberry PI.

#### Option B: TVService

This should already be installed on the Pi by default.


### Turn on and off the monitor periodically.

Edit this file according to the comments to disable CEC support and use standard TV Service support if you don't have a monitor that supports CEC.

```bash
sudo touch /usr/local/sbin/screen
sudo chmod 755 /usr/local/sbin/screen
sudo vi /usr/local/sbin/screen
```

Paste the contents of either the `src/screen-cec.sh` or `src/screen-tv.sh` file and save.

Setup `cron` to call the new `screen` script and tell the system to auto start `cron` on boot.

```bash
sudo crontab -l > root-cron
echo "0 6 * * * /usr/local/sbin/screen on 2> /usr/local/sbin/screen.err.log" >> root-cron
echo "0 11 * * * /usr/local/sbin/screen off 2> /usr/local/sbin/screen.err.log" >> root-cron
echo "" >> root-cron
sudo crontab root-cron
rm root-cron
sudo service cron restart
sudo update-rc.d cron defaults
```


### Restart the pi.
```bash
sudo reboot -h now
```
