This is a lxc container capable running steam and supports nvidia gpu for vulkan/opengl applications.

Nvidia runtime is not complete and this contains a fix 
adding the missing files and libraries see `launch.sh` and
https://discourse.ubuntu.com/t/unable-to-use-nvidia-gpu-in-container-intel-built-in-gpu-works/41899/16.

Usage
===

Create steam profile:
```
lxc profile create steam
lxc profile edit steam < steam.profile
```

Launch instance:
```
./launch.sh
```

Login as ubuntu user:
```
lxc exec steam -- sudo --user ubuntu --login
``` 

Test gpu:
```
nvidia-smi
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo -B
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears -info
vulkaninfo --summary
vkcube --gpu_number 1
``` 

Start steam application
```
lxc exec steam -- sudo --user ubuntu --login
$ ./start-steam.sh
```

If steam fails to update libraries run:
``` 
sudo steamdeps --no-install-confirmation $HOME/.steam/steam/steamdeps.txt
```

Start steam container: `lxc start steam`
Stop steam container: `lxc start steam`


System information:
``` 
dmidecode
xrandr --listproviders
vulkaninfo --summary
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo -B
nvidia-smi
``` 

References
===

https://blog.simos.info/running-steam-in-a-lxd-system-container/
https://blog.simos.info/running-x11-software-in-lxd-containers/

https://github.com/ValveSoftware/Proton
https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/blob/master/pressure-vessel/wrap.1.md
https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/issues/35

https://discuss.linuxcontainers.org/t/how-secure-is-security-nesting-true/2919

https://discourse.ubuntu.com/t/lxd-incus-profile-for-gui-apps-wayland-x11-and-pulseaudio/40255

https://github.com/KhronosGroup/Vulkan-Loader/issues/262

https://gist.github.com/davispuh/6600880

https://download.nvidia.com/XFree86/Linux-x86_64/435.17/README/primerenderoffload.html