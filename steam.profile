config:
  environment.DISPLAY: :0
  environment.PULSE_SERVER: unix:/home/ubuntu/pulse-native
  security.nesting: true
  user.user-data: |
    #cloud-config
    runcmd:
      - 'dpkg --add-architecture i386'
      - 'apt-get update'
      - 'apt-get install -y x11-apps:i386'
      - 'apt-get install -y mesa-utils:i386'
      - 'apt-get install -y libgl1-mesa-glx:i386'
      - 'apt-get install -y libcanberra-gtk-module:i386'
      - 'apt-get install -y pulse-audio'
      - 'apt-get install -y pulseaudio-utils'
      - 'apt-get install -y dbus-x11'
      - 'apt-get install -y libvulkan1:i386 libvulkan1 mesa-vulkan-drivers:i386 mesa-vulkan-drivers vulkan-utils'
      - 'sed -i "s/; enable-shm = yes/enable-shm = no/g" /etc/pulse/client.conf'
      - 'echo export PULSE_SERVER=unix:/home/ubuntu/pulse-native | tee --append /home/ubuntu/.profile'
      - 'wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb'
      - 'dpkg -i /steam.deb'
      - 'apt-get install -y -f'
description: Steam LXD profile
devices:
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
    connect: unix:/tmp/.X11-unix/X1
    listen: unix:/tmp/.X11-unix/X0
    security.gid: "1001"
    security.uid: "1001"
    uid: "1000"
    gid: "1000"
    mode: "0777"
    type: proxy
  mygpu:
    type: gpu
    gid: 44
name: steam
