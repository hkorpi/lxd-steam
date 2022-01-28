https://blog.simos.info/running-steam-in-a-lxd-system-container/
https://blog.simos.info/running-x11-software-in-lxd-containers/

https://github.com/ValveSoftware/Proton
https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/blob/master/pressure-vessel/wrap.1.md
https://gitlab.steamos.cloud/steamrt/steam-runtime-tools/-/issues/35

https://discuss.linuxcontainers.org/t/how-secure-is-security-nesting-true/2919

start:
lxc start steam

login:
lxc exec steam -- sudo --user ubuntu --login

machine info:
dmidecode

vulkan
https://github.com/KhronosGroup/Vulkan-Loader/issues/262

if vulkaninfo fails
run: `setfacl -m "u:ubuntu:rw-" /dev/dri/*`

testing:
vulkaninfo
vulkan-smoketest
