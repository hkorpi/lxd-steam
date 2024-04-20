config:
  environment.DISPLAY: :1
  environment.PULSE_SERVER: unix:/home/ubuntu/pulse-native
  nvidia.driver.capabilities: all
  nvidia.runtime: true
  security.nesting: true
  cloud-init.user-data: |
    #cloud-config
    package_upgrade: true
    packages:
      - x11-apps
      - x11-xserver-utils
      - mesa-utils
      - pulseaudio
      - pulseaudio-utils
      - dbus-x11
      - vulkan-tools
    runcmd:
      - 'sed -i "s/; enable-shm = yes/enable-shm = no/g" /etc/pulse/client.conf'
      - 'wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb'
      - 'apt-get update'
      - 'dpkg -i /steam.deb'
      - 'apt-get install -y -f'
      - 'rm -f /steam.deb'
description: Steam LXD profile
devices:
  steam:
    source: /media/mika/steam
    path: /home/ubuntu/games
    type: disk
    shift: true
  PASocket:
    bind: container
    connect: unix:/run/user/1001/pulse/native
    listen: unix:/home/ubuntu/pulse-native
    security.gid: "1001"
    security.uid: "1001"
    uid: "1000"
    gid: "1000"
    mode: "0777"
    type: proxy
  X0Socket:
    bind: container
    connect: unix:/tmp/.X11-unix/X2
    listen: unix:/tmp/.X11-unix/X1
    security.gid: "1001"
    security.uid: "1001"
    uid: "1000"
    gid: "1000"
    mode: "0777"
    type: proxy
  mygpu:
    type: gpu
    gid: 44
    #pci: 0000:01:00.0
name: steam
