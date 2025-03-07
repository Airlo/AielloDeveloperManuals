# Liunx

## / 文件结构

Linux目录类似一个树，最顶层是其根目录

* 通常情况下，根文件系统所占空间一般应该比较小，因为其中的绝大部分文件都不需要经常改动，而且包括严格的文件和一个小的不经常改变的文件系统不容易损坏。

* 除了可能的一个叫/ vmlinuz标准的系统引导映像之外，根目录一般不含任何文件。所有其他文件在根文件系统的子目录中。

* 只有root用户具有该目录下的写权限。请注意，/root是root用户的主目录，这与/.不一样

[(12条消息) Linux下目录含义【最详细】_ChengKaoAO的博客-CSDN博客](https://blog.csdn.net/ZmeiXuan/article/details/78052577)

**安装时分区推荐**

* 真正安装时必须指定efi、/boot和/，其余都可以自动分配
* swap交换空间与系统内存保持一致或+5G(系统内存小的时候可以设置双倍)
* EFI系统分区，4G即可
* 根目录150G-200G，挂载点为 / 
* 内核以及引导程序所需要的文件，空间起始位置，1G-8G，ext4 挂载在 /boot
* 挂载在/home，尽量大

**特殊含义**

./ 的含义 #当前目录，.是代表此目录本身，但是一般可以不写 所以cd ~/. 和cd ~ 和cd ~/效果是一样的
~/ 的含义 #根目录，当前登录用户的用户主文件夹，而/root是root用户的主目录
./.local 中 local 前面的那个 . 的含义 #.英文点号表示这是个隐藏文件或隐藏文件夹

### /bin \- 用户二进制文件

存放最常用命令

所有用户都可以访问并执行的可执行程序。包括超级用户及一般用户。

包含二进制可执行文件。 在单用户模式下，你需要使用的常见Linux命令都位于此目录下。系统的所有用户使用的命令都设在这里。 例如：ps、ls、ping、grep、cp

### /etc \- 配置文件

包含所有程序所需的配置文件。 也包含了用于启动/停止单个程序的启动和关闭shell脚本。例如：/etc/resolv.conf、/etc/logrotate.conf

/etc目录存放着各种系统配置文件，其中包括了用户信息文件/etc/passwd，系统初始化文件/etc/rc等。linux正是这些文件才得以正常地运行。

#### sudoers

```bash
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
```

**警告：更改sudoers可能会导致sudo指令无可用规则而使用户失去超级管理员权限**

可以通过grub进入recovery模式输入root密码重新更改sudoers，或在终端su root（都需要设置并输入正确的root用户密码）

可以通过以下命令直接进入sudoers更改

```bash
pkexec visudo  # visudo指打开sudoers
```

**sudo: no tty present and no askpass program specified**

```bash
# 面对此问题可以通过修改sudoers增加用户权限
%sudo ALL=(ALL:ALL) ALL
[Username] ALL=(ALL)NOPASSWD:ALL
```

**！严重警告：千万不要更改sudoers的权限，可能会永久失去sudo**

```bash
sudo: /etc/sudoers is world writable
sudo: no valid sudoers sources found, quitting
sudo: unable to initialize policy plugin
```

如果不幸因为权限问题失去了sudo，pkexec命令也会失效，只可能通过su进入root权限或者recoverymode进入root权限修改，如果设置但是忘记了root的密码，只有recoverymode并修改启动脚本以单用户状态启动才可能取回

```bash
# 在进入grub界面选择高级模式在选择内核启动版本时按e键，把ro recovery nomodeset改成rw single init=/bin/bash
ro recovery nomodeset -> rw single init=/bin/bash
# 然后ctrl+x进入单用户模式
```

##### 建议

```bash
# 推荐使用sudo visudo来更改sudoers，效果等同于sudo vi /etc/sudoers，但是会有一步检查可用性的操作
sudo visudo
```

#### default
##### grub 
```shell
sudo vim /etc/default/grub
# 1. 进行默认启动项修改:
# 找到GRUB_DEFAULT，数字代表对应顺序条目，1> 2代表第1顺序条目选择后在二级菜单选择2
# 2. 安静启动模式
# 找到GRUB_CMDLINE_LINUX_DEFAULT，设置为GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=nommconf"
# 或者根据想要屏蔽的日志值设置为noaer
sudo update-grub
```

#### netplan
##### 01-network-manager-all.yaml
```yaml 
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    ens33:
      addresses: [192.168.2.67/24]    # 内网网卡不设置网关与DNS
      dhcp4: no 
    ens44:
      addresses: [192.168.1.67/24]
      dhcp4: no
      gateway4: 192.168.1.1
      nameservers:
        addresses: [192.168.1.1]
  wifis:           
    wlan0:     
      access-points:
        HUAWEI: 
          auth:
            key-management: psk
            password: "Your PassWord"
      dhcp4: yes      
      optional: true    
```
```shell 
sudo netplan apply
```

#### pam.d

#### init.d

#### rc.local

#### network

#### profile

系统环境变量配置文件

interfaces

### /lib - 系统库

根文件系统上的程序所需的共享库，存放了根文件系统程序运行所需的共享文件。这些文件包含了可被许多程序共享的代码，以避免每个程序都包含有相同的子程序的副本，故可以使得可执行文件变得更小，节省空间。

包含支持位于/bin和/sbin下的二进制文件的库文件. 库文件名为 ld*或lib*.so.* 例如：ld-2.11.1.so，libncurses.so.5.7

#### /lib/modules

目录包含系统核心可加载各种模块，尤其是那些在恢复损坏的系统时重新引导系统所需的模块(例如网络和文件系统驱动)。

#### /lib/systemd



### /dev \- 设备文件

包含设备文件。 这些包括终端设备、USB或连接到系统的任何设备。例如：/dev/tty1、/dev/usbmon0

目录存放了设备文件，即设备驱动程序，用户通过这些文件访问外部设备。比如，用户可以通过访问/dev/mouse来访问鼠标的输入，就像访问其他文件一样。

/dev/audio



### /var \- 变量文件



### /usr \- 用户程序

包含二进制文件、库文件、文档和二级程序的源代码

#### /usr/bin

包含用户程序的二进制文件。如果你在/bin中找不到用户二进制文件，到/usr/bin目录看看。例如：at、awk、cc、less、scp。

系统安装时自带的一些可执行程序。即系统程序，轻易不要去动里面的东西，容易入坑。

#### /usr/include - 系统头文件

#### /usr/lib

包含了/usr/bin和/usr/sbin用到的库。

##### /usr/lib/x86_64-linux-gnu



#### /usr/src - Linux源代码

源代码，linux内核的源代码就放在/usr/src/linux里

#### /usr/local

包含了从源安装的用户程序。例如，当你从源安装Apache，它会在/usr/local/apache2中。

##### /usr/local/bin

用户自行编译安装时默认的可执行程序的安装位置，这个不小心误删点什么，不会影响大局。

### /opt \- 可选的附加应用程序

opt代表可选的。 包含从个别厂商的附加应用程序。 附加应用程序应该安装在/opt/或者/opt/的子目录下

### /proc - 内核设置内部数据结构

#### /proc/sys/

##### /proc/sys/kernel

core_pattern文件涉及系统处理终端的错误抛出

#### /proc/asound

### /home - 用户目录

```shell
~/.bash_profile  # 这个是用户环境变量配置文件
source ~/.bashrc  # 或者~/.zshrc 根据 echo $0 出来的shell确定
# 通过 echo ~ 可以看到代表的用户目录
echo ~  # 比如/home/aiello
```



## 服务service管理


#### rc.local

#### networking
#### network-manager

#### bluetooth.service

```bash
# rfkill报错： Failed to set mode:Blocked through rfkill（0x12）
sudo rfkill unblock bluetooth # 使得rfkill解除对蓝牙服务的封锁
sudo systemctl start bluetooth.service # 重启蓝牙服务
# hci0报错： loadin LTKs timed out for hci0
sudo hciconfig hci0 down # 配置hci0蓝牙设备关闭
sudo rmmod btusb # 移除btusb蓝牙模块
sudo modprobe btusb # 重新加载btusb蓝牙模块
sudo hciconfig hci0 up # 配置hci0蓝牙设备启动
sudo systemctl start bluetooth.service # 重启蓝牙服务
```

#### systemctl

syetemctl就是对service和chkconfig这两个旧命令的整合	

```bash
systemctl list-units --type=service # 显示所有已开启的服务
```

#### systemd-analyze

```shell
systemd-analyze blame  # 查看开机启动项耗时
systemd-analyze time  # 查看总的开机时间
systemd-analyze critical-chain  # 启动时间树状图
systemd-analyze plot > ~/SystemdAnalyzePlot.svg  # 生成开机时间分析图，可以用图片或者浏览器打开看
systemctl disable 启动项名称.service  # 禁用该启动项
systemctl mask 启动项名称.service  # 强力禁用该启动项，确保其他项也不能唤起它
```

#### systemd-journal-flush.service

如果观察到该服务拖累了系统启动的速度，这是由于系统文件存储了太多的**journal**导致的，检查/var/log/journal文件夹

```shell
# 查看占据磁盘大小
journalctl --disk-usage
# 清除一些磁盘上的老的文件
sudo rm -rf /var/log/journal/
# 并在/etc/systemd/journald.conf配置文件中将默认存储容量缩小
# 设置 SystemMaxFileSize=1G，SystemMaxFiles=5
```

#### ssh

[Ubuntu安装SSH服务器故障分析及解决办法（错误1：E:软件包 openssh-server 还没有可供安装的候选者，错误2：E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系）-布布扣-bubuko.com](http://www.bubuko.com/infodetail-1869977.html)

[Ubuntu安装SSH服务器故障分析及解决办法（错误1：E:软件包 openssh-server 还没有可供安装的候选者，错误2：E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系） (bbsmax.com)](https://www.bbsmax.com/A/xl56GA9drZ/)

[(13条消息) 在Ubantu18.04上开启ssh服务，实现远程连接_szkai_凯的博客-CSDN博客](https://blog.csdn.net/weixin_42739326/article/details/82260588)

[ubuntu使用ssh连接远程电脑的方法 - 瘋耔 - 博客园 (cnblogs.com)](https://www.cnblogs.com/qiynet/p/5593464.html)

[(13条消息) ROS中两个电脑之间ssh通信（ROS多机通信计算机网络配置）_小岛上的八块腹肌的博客-CSDN博客](https://blog.csdn.net/weixin_41245919/article/details/94764689)

#### 自定义服务

```bash
# 将自定义服务存储在/lib/systemd/system/下
sudo update-rc.d [service_name] start  # 开启服务
sudo update-rc.d [service_name] remove  # 取消服务
```



### 服务端口开放

#### iptables

```bash
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT # 开放指定端口如8000
sudo iptables-save # 保存
sudo apt-get install iptables-persistent # 通过netfilter-persistent永久保存
sudo netfilter-persistent save
sudo netfilter-persistent reload
# 查看端口是否有程序监听
netstat -ap | grep s[port]
```

### 服务器与网络

网络手动固定配置

### TCP端口检测、网络连接时延测试工具 tcping

```python
def tcp(ip, port, timeout=2): sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM) sk.settimeout(timeout) try: t1 = time.time() sk.connect((ip, port)) t2 = time.time() sk.close() return True, int(round((t2-t1)*1000)) except Exception: sk.close() return False, timeout*1000
# 完整代码：https://github.com/zhangnq/scripts/blob/master/python/tcping.py
```

下载安装：

```bash
wget http://download.chekiang.info/tool/tcping -O /usr/bin/tcping 
chmod +x /usr/bin/tcping
```

#### 拒绝访问

**安装**

```zsh
sudo apt-get install vnc4server
sudo apt-get install openssh-server
```

#### 未开启telnet服务 Unable to connect to remote host: Connection refused

**安装**

```bash
sudo apt-get install telnetd-ssl
sudo apt-get install telnetd
sudo apt-get install xinetd
cat /etc/inetd.conf  | grep telnet 
```

telnet 与 xinetd 的关系：xinetd是新一代的网络守护进程服务程序，telnet进程由xinetd守护
**配置**

```bash
# 配置文件1：
sudo vim /etc/xinetd.conf
# 添加
defaults
{
	instances = 60
	log_type = SYSLOG authpriv
	log_on_success = HOST PID
	log_on_failure = HOST
	cps = 25 3
}
includedir /etc/xinetd.d

# 配置文件2：
sudo vim /etc/xinetd.d/telnet
# 增加/修改
	# default: on
	# description: The telnet server serves telnet sessions; it uses \
	# unencrypted username/password pairs for authentication.
service telnet 
{
    disable = no  
    Instance =UNLIMITED 
    Nice =0
    flags = REUSE
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/in.telnetd
    log_on_failure += USERID
}

# 重启服务
sudo /etc/init.d/xinetd restart
```

### 图形化

#### X Window

[startx及xinit介绍](https://blog.csdn.net/qq_39101111/article/details/78728857)

[Linux的XServer常识](https://blog.csdn.net/arv002/article/details/124450634)

[XServer基本概念+x11vnc配置远程桌面](https://blog.csdn.net/lovewangtaotao/article/details/102907540?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-1-102907540-blog-124450634.pc_relevant_default&spm=1001.2101.3001.4242.2&utm_relevant_index=4)

##### gdm.service

###### Q1. ubuntu18.04无法正常启动gdm3

问题症状：无任何操作下，启动卡在ubuntu加载图标界面；除了无法图形化外其他一切正常，启动界面也没有报错，直到卡在starting Gnome Display Manager；查看启动状态时发现服务启动到gdm3便进行不下去了；(EE) systemd-logind: failed to get session: PID xxx 

**解决方法1 针对Wayland在某些图形驱动程序中存在的错误（使用但未成功解决）**

停用Wayland修改/etc/gdm3/custom.conf，注释或启用注释WaylandEnable=false，即让GNOME显示管理器始终通过gnome-desktop而非Wayland加载GNOME桌面环境

**解决方法2  怀疑gdm本身与18.04存在不兼容，转而使用lightdm取代gdm（未使用）**

```bash
sudo aptitude install lightdm
sudo dpkg-reconfig lightdm
```

**解决方法3 检查gnome是否在apt操作中被破坏（使用但未成功解决）**

```bash
sudo aptitude install ubuntu-gnome-desktop
sudo gnome-shell gnome
# reboot或运行如下命令
sudo systemctl restart gdm3
```

**解决方法4 syslog错误引发gdm-x-session错误，对gdm-launch-session进行编辑（未使用）**

在某些包安装时会执行pam-auth-update，这会将pam_systemd添加到/etc/pam.d/common-session中从而引发gdm的问题

```bash
# 在/etc/pam.d/gdm-launch-environment中添加下行
session optional     pam_systemd.so
```

**解决方法5 诊断为未知的内核兼容问题，更换内核（使用并成功）**

主要是从内核4.15.0-193-generic切换到了4.15.0-191-generic

**解决方法6 193版本内核问题，卸载内核并重新安装gdm3（未使用）**

```bash
sudo apt purge linux-image-4.15.0-193-generic liunx-image-4.15.0-193*
sudo apt purge gdm3
sudo apt-get install gdm3 ubuntu-desktop
# sudo systemctl enable networking
```

###### Q2. ubuntu18.04开机无背景，全黑屏，只有鼠标

```bash
# 进入命令行ctrl+alt+f2,
# 解决无背景，黑屏
sudo apt update
sudo apt install lightdm
reboot
# 解决有背景，无图片
sudo apt-get install --reinstall ubuntu-desktop
sudo apt-get install unity
sudo service lightdm restart
```

#### VNC

关于防火墙是否可以关闭：没有必要关闭

```bash
# 启动vnc，在5901端口
vncserver :1 -geometry 1920x1000 -depth 24
```

##### xstartup文件

```bash
# Ubuntu20.04
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic & 
gnome-session --session=gnome-flashback-metacity --disable-acceleration-check &

# Ubuntu18.04(now)
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
gnome-panel &
# gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal & 
gnome-session --session=gnome-flashback-metacity --disable-acceleration-check &

# Ubuntu18.04(maybe)
#!/bin/sh
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"
gnome-session --session=gnome-flashback-metacity --disable-acceleration-check &
```

[(28条消息) 如何在Ubuntu 18.04上安装和配置VNC_cukw6666的博客-CSDN博客](https://blog.csdn.net/cukw6666/article/details/107984744)

[How to Install and Configure VNC on Ubuntu 18.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04)

[ubuntu安装vnc，远程链接时出现灰屏，配置文档不对吗？ (zhihu.com)](https://www.zhihu.com/tardis/sogou/ans/2322484295)

[安装vnc出现的问题 - 弦灬烨 - 博客园 (cnblogs.com)](https://www.cnblogs.com/lianxuan1768/p/8195514.html)

##### TurboVNC

VirtualGL的原理相当于创建一个虚拟的显卡，抓取应用软件的渲染指令，转发给GPU渲染，再将GPU输出的图像输出给X-server。这样，vnc就能愉快地从X-server拿到完整的截图。由于又是X-server级别的图像抓取，不存在多用户的问题。

当然普通的vnc都有各自奇奇怪怪的OpenGL解决方案，所以VirtualGL项目有专门做了一个亲生的vnc软件，TurboVNC。TurboVNC主打性能，号称他们神奇的算法可以在高延迟低带宽的场景下提供流畅的体验。当然他们的重点是可以和自家的VirtualGL一起用。

全新的替代方案，安装deb即可

```shell
sudo apt install libturbojpeg libxt6 libxext6 libsm6 libx11-6 libice6 libbsd0 libxcb1 libx11-data libxau6 libxdmcp6 x11-common x11-xkb-utils xauth
wget https://nchc.dl.sourceforge.net/project/turbovnc/2.2.6/turbovnc_2.2.6_amd64.deb
dpkg -i turbovnc_2.2.6_amd64.deb
# 指定可视化终端端口，:1对应默认端口5901
export DISPLAY=:1
# 以不启动图形界面的方式启动vncserver
/opt/TurboVNC/bin/vncserver -3dwm -noxstartup $DISPLAY
# kill 进程
/opt/TurboVNC/bin/vncserver -kill :n
```

客户端访问

##### noVNC

[ubuntu配置novnc通过web访问服务器](https://blog.csdn.net/happyday_d/article/details/100514110)

## Shell

Shell（壳）是一种用C语言编写的程序（命令解释器），是连接用户和Unix/Linux内核的桥梁。 它的功能和windows的图形界面是一样的，只不过操作的形式不一样。   它通过建立文件的形式并行的运行多个程序，帮助用户完成很多工作；
Shell是一种命令语言，也是一种程序设计语言。 作为命令语言的时候，shell的工作形式是交互式的，用户输入一行命令，shell根据命令内容给出用户反馈信息；   作为程序设计语言时，shell的工作形式是非交互式的，在它的程序语言中，提供了许多参数和变量，并具有在高级程序语言中才具有的控制结构（if case while ），但是，shell程序不需要编译，而是从脚本文件中读取一行命令，执行一行，所以又称为解释行语言。

```shell
cat /etc/shells # 查看当前主机中包含的shell类型，常见的类型有Bourne Again Shell(Bash)、Bourne Shell、C-shell、Korn Shell
echo $SHELL # 查看当前使用的shell类型
ps -p $$ # 查看当前使用的shell类型
bash --version # 查看bash的版本
```

### sh脚本

当Shell执行一个程序时会要求UNIX内核启动一个新的进程来执行指定的程序

#!/bin/sh 的含义：特殊符号+脚本解释器的路径

不写系统使用的是默认脚本解释器

事实上这种以特殊符号**‘#!'**引导的类似的方式有助于执行机制的通用化，让用户得以直接引用任何的程序语言解释器（如python），而**‘#!’**实际是一个2字节的魔法数字，是指定一个文件类型的特殊标记

![img](https://img-blog.csdnimg.cn/20190130165112160.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwNjI4MTA2,size_16,color_FFFFFF,t_70)

![img](https://img-blog.csdnimg.cn/20190130181222153.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwNjI4MTA2,size_16,color_FFFFFF,t_70)

#### 运行.sh

**第一种**

需要chmod使得文件具备执行条件，如

```shell
chmod u+x datelog.sh
/root/datelog.sh
./datelog.sh
```

在任何路径下，输入该文件的绝对路径/root/datelog.sh就可执行该文件（当然要在权限允许情况下），或者cd到datelog.sh文件的目录下，然后执行./datelog.sh

**第二种**

这种办法不需要文件具备可执行的权限也可运行

```shell
sh datelog.sh
sh /root/datelog.sh
```



## 内核 Kernel

### 实时内核

查看当前系统内核若有rt字样则代表使用的是实时内核

[两种使ubuntu拥有RT内核的方法](https://zhuanlan.zhihu.com/p/675155576)

上述教程中实时内核nivida驱动安装脚本链接到Apollo自驾平台开源的Apollo-kernel项目

第一种为通过打补丁获得4个deb文件的安装方式；

第二种为[https://xanmod.org/](https://link.zhihu.com/?target=https%3A//xanmod.org/)直接下载安装RT内核的方式

## 第三方内核

### Xanmod

- XanMod 基于最新的稳定版 Linux 内核构建，旨在提供稳定、流畅且可靠的系统体验。
- XanMod 由社区开发和维护，汲取了其他内核的优点，同时添加了独家优化，特别适合桌面、多媒体和游戏等场景，让系统更流畅、更灵敏。

* 使用第三方内核需要一定的技术背景，并且稳定性可能不如 Linux 发行版的官方内核。

## 驱动与引导

### 引导疑难

### 显卡驱动

#### Nvidia官方驱动提供
(https://www.nvidia.cn/Download/index.aspx?lang=cn#)

[(12条消息) ubuntu下安装NVIDIA显卡：问题解决记录_tiny_ten的博客-CSDN博客](https://blog.csdn.net/shenquanyue/article/details/82591846)

[(12条消息) 老电脑装ubuntu后 分辨率只有640*480 的解决办法_今晚打酱油8的博客-CSDN博客](https://blog.csdn.net/xj626852095/article/details/47703565)

[(12条消息) 解决Ubuntu屏幕分辨率不正常问题_iimmortall的博客-CSDN博客](https://blog.csdn.net/ignoreyou/article/details/79488442)

[(12条消息) ubuntu安装后分辨率只有一个选项_Joy-com的博客-CSDN博客_ubuntu分辨率只有一个选项](https://blog.csdn.net/u013764485/article/details/78007370)

[(12条消息) ubuntu下安装NVIDIA显卡：问题解决记录_tiny_ten的博客-CSDN博客](https://blog.csdn.net/shenquanyue/article/details/82591846)

#### Nouveau开源驱动

Nouveau 是由社区开发的开源 NVIDIA 显卡驱动程序。它是 X.Org 的一部分，支持大多数 NVIDIA 显卡。Nouveau 的优点是开源且与 Linux 内核和其他开源组件集成良好，但它的缺点是性能通常不如 NVIDIA 官方驱动，并且不支持最新的 NVIDIA 显卡和一些像CUDA这样的高级功能。

### 声卡驱动

[(22条消息) Ubuntu 声卡解决办法合集_sondx的博客-CSDN博客](https://blog.csdn.net/sondx/article/details/8961865)

#### ALSA

Advanced Linux Sound Architecture 的简称为 ALSA ，译成中文的意思是先进的Linux声音架构（这是google翻译的）；一谈到架构就有点范围太大了，所以ALSA不仅仅是包括对声卡的支持和驱动；

ALSA具有如下特征：

1、对所有音频接口的高效支持，从普通用户的声卡到专业级别多路音频设备；

2、声卡驱动完全模块化设计；

3、SMP and thread-safe design.

4、开发库（alsa-lib） 为程序设计提供了简单、方便，并且拥有有高级的效果和功能；

5、支持旧版本的OSS API 结口，能为大多数的OSS应用程序提供兼容；OSS是一个商业性的驱动，OSS有一个简装本的代码已经移入内核和ALSA，其中alsa-oss就是；OSS公司据说目前已经并不存在了；我们没有必要用OSS 公司提供的商业版本；用ALSA和OSS简装版足够

### 蓝牙驱动

[(28条消息) Ubuntu14.04 蓝牙适配器的连接_can't init device hci0: connection timed out (110)_Being_young的博客-CSDN博客](https://blog.csdn.net/u013019296/article/details/70051762)

[(28条消息) ubuntu 20.04配置蓝牙以及 btusb not found解决_ubuntu 蓝牙驱动_LuH1124的博客-CSDN博客](https://blog.csdn.net/weixin_43357695/article/details/126087105)

## 版本冲突与共存

[(12条消息) Ubuntu16.04下opencv2与ROSkinetic中自带opencv3不兼容问题总结_龙性的腾飞的博客-CSDN博客](https://blog.csdn.net/qq_30460905/article/details/79845156)

[(12条消息) 安装Ubuntu16.04+OpenCV3.3.1+ROS kinetic_yzcece的博客-CSDN博客](https://blog.csdn.net/yzcece/article/details/82721082)

[(12条消息) ubuntu下检查python版本，进入、退出python解释器、给予文件执行许可--ubuntu下python的学习（1）_今天风和日丽的博客-CSDN博客](https://blog.csdn.net/Z545097262/article/details/74094319)

[(12条消息) Ubuntu16.04系统查看已安装的python版本，及Python2与Python3之间切换_口袋里のInit的博客-CSDN博客_树莓派查看python版本](https://blog.csdn.net/wangguchao/article/details/82151372)

[请问ubuntu如何优雅地解决依赖冲突和管理软件包 - Ubuntu中文论坛](https://forum.ubuntu.org.cn/viewtopic.php?p=3217961)

[(12条消息) ubuntu下安装包依赖关系（问题）& apt包管理工具（解决方法）_青豆1113的博客-CSDN博客_apt自动解决依赖关系](https://blog.csdn.net/qq_31811537/article/details/79319565)

[Ubuntu 16.04安装qt5-default报错：qt5-default : 依赖: qtbase5-dev E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系。（此类问题终极解决方法） (bbsmax.com)](https://www.bbsmax.com/A/QV5ZYaEnJy/)

[(12条消息) Ubuntu apt-get彻底卸载软件包_mjiansun的博客-CSDN博客_apt删除软件包](https://blog.csdn.net/u013066730/article/details/80893374)

#### ubuntu系统apt安装软件提示dpkg被占用

```shell
# 1.通过文件句柄查找进程占用
sudo lsof /var/lib/dpkg/lock
sudo lsof /var/lib/apt/lists/lock
sudo lsof /var/cache/apt/archives/lock
sudo lsof /var/lib/dpkg/lock-frontend
# 2.审查进程并kill
# 3.安全删除锁定文件
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock  # 强制解锁
# 4.重新配置包
sudo dpkg --configure -a
# 5.检查锁占用
sudo apt update
```



## 历史与组织

### Linux基金会

[(12条消息) 开源简史基础：Linux基金会_淼叔的博客-CSDN博客](https://blog.csdn.net/liumiaocn/article/details/100666545)

We’re helping open technology projects build world class open source software, communities and companies.

## 安全和备份

### 建议

```bash
# 安装过程中如果有错
sudo aptitude --fix-broken install
```

### 不建议

```bash
# 关于错误：ERROR: Could not install packages due to an EnvironmentError: [Errno 13] 权限不够: ‘/usr/local/lib/python3.5/dist-packages/itsdangerous-1.1.0.dist-info’ Consider using the --user option or check the permissions. 的解决办法是：安装的时候添加–user参数
pip install [package] --user
```

### 处理简单故障的包

```bash
sudo apt install exfat-fuse exfat-utils # 不支持EXFAT格式U盘
sudo apt-get install ibus-clutter # 中文输入法
sudo apt-get install ibus-libpingyin # 中文输入法
sudo apt-get install net-tools traceroute # 网络工具包
```

### 安装和包管理
#### apt、apt-get
使用apt-get install来安装应用程序算是最常见的一种安装方法了，比如要安装build-essential这个软件，会把所有的依赖包都一起安装。
apt-get理论上是要求能够联网，但是如果制作了本地源，就不需要联网，制作本地源可以参考：[ubuntu制作本地源 - xwdreamer - 博客园 (cnblogs.com)](https://www.cnblogs.com/xwdreamer/p/3875857.html)

##### 添加公钥

```bash
# 解决W GPG缺少源对应公钥
# http://packages.ros.org/ros/ubuntu xenial InRelease 对应
 sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
```



##### 基本命令

```shell
sudo apt-get update  # 更新源
sudo apt-get install package  # 安装包
sudo apt-get remove package # 删除包
sudo apt-cache search package  # 搜索软件包
sudo apt-cache show package  # 获取包的相关信息，如说明、大小、版本等
sudo apt-get install package –reinstall  # 重新安装包
sudo apt-get -f install  # 修复安装
sudo apt-get remove package –purge  # 删除包，包括配置文件等
sudo apt-get build-dep package  # 安装相关的编译环境
sudo apt-get upgrade  # 更新已安装的包
sudo apt-get dist-upgrade  # 升级系统
sudo apt-cache depends package  # 了解使用该包依赖那些包
sudo apt-cache rdepends package  # 查看该包被哪些包依赖
sudo apt-get source package  # 下载该包的源代码
sudo apt-get clean && sudo apt-get autoclean  # 清理无用的包
sudo apt-get check  # 检查是否有损坏的依赖
apt --fix-broken install
```

#### dpkg

Ubuntu软件包格式为deb，安装方法如下：

```shell
sudo dpkg -i package.deb  # 安装软件 命令行
```

根据Ubuntu中文论坛上介绍，使用apt-get方法安装的软件，所有下载的deb包都缓存到了/var/cache/apt/archives目录下了，所以可以把常用的deb包备份出来，甚至做成ISO工具包、刻盘，以后安装Ubuntu时就可以在没有网络环境的情况下进行了。下面的命令是拷贝archives这个目录到/var/cache/apt/目录下，替换原有的archives

```shell
sudo cp -r archives/ /var/cache/apt
```

**dpkg 被中断,您必须手工运行 sudo dpkg --configure -a解决此问题**

```bash
# 解决思路：/var/lib/dpkg/updates 文件夹里面的资料有错误，使得更新软件的程序出现错误，所以得把它们完全删除
sudo rm /var/lib/dpkg/updates/*
sudo apt-get update
# sudo apt-get upgrade
```

**其他命令**

```shell
dpkg -C  # 查找只有部分安装的软件包信息
dpkg –compare-versions ver1 op ver2  # 比较同一个包的不同版本之间的差别
dpkg –licence (or) dpkg –license  # 显示dpkg的Licence 命令行
dpkg –version  # 显示dpkg的版本号
dpkg -l package-name-pattern  # 搜索Deb 命令行
dpkg -l  # 显示所有已经安装的Deb包，同时显示版本号以及简短说明
dpkg -p package-name  # 显示包的具体信息
```

#### make install

如果要使用make安装的话，那么必须得安装build-essential这个依赖包，安装方法已经在前面说过了。在安装完毕以后，我们就可以进行源码安装。源码安装大致可以分为三步骤：（./configure）–＞ 编译（sudo make） –＞ 安装（sudo make install）。

1. 配置：这是编译源代码的第一步，通过 `./configure` 命令完成。执行此步以便为编译源代码作准备。常用的选项有 `--`prefix=PREFIX，用以指定程序的安装位置。更多的选项可通过 `--`help 查询。也有某些程序无需执行此步。
2. 编译：一旦配置通过，可即刻使用 `make` 指令来执行源代码的编译过程。视软件的具体情况而定，编译所需的时间也各有差异，我们所要做的就是耐心等候和静观其变。此步虽然仅下简单的指令，但有时候所遇到的问题却十分复杂。较常碰到的情形是程序编译到中途却无法圆满结束。此时，需要根据出错提示分析以便找到应对之策。
3. 安装：如果编译没有问题，那么执行 `sudo make install` 就可以将程序安装到系统中了。
4. 一些问题解答：

[(12条消息) Linux Python: 出现directory is not owned by the current user警告_高精度计算机视觉的博客-CSDN博客](https://blog.csdn.net/tanmx219/article/details/86532759)

#### snap

#### flatpkg

#### python setup.py install

是我们用来安装下载的python包或者自己按照python官方规范开发的扩展包的常用指令，通过这个命令，这个python包就会被安装系统或者你指定用户的python库里（http://structure.usc.edu/python/inst/standard-install.htm）

**python setup.py install**包括两步：

```bash
python setup.py build  # python编译这个module的过程, 这个过程比较复杂，最后会生成build文件夹
python setup.py install  # 复制build/lib文件到用户指定的lib库
# 这两步，可分开执行，也可只执行python setup.py install，因为python setup.py install总是会先build后install
# 使用初始条件：python-devel、gcc已安装， 希望安装的源码包已下载和解压
```

### 备份

[用tar备份和恢复Linux系统-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/637490)

[(13条消息) Ubuntu用tar备份与恢复方法_Richard_J的博客-CSDN博客](https://blog.csdn.net/jiangnan_java/article/details/12236331)

http://t.zoukankan.com/sparkdev-p-10470144.html

## 系统监控与守护

#### 常用系统命令

```shell
htop  # 完整面板 需要apt install htop
uname -a  # 查看系统版本/架构/内核/操作系统/CPU信息的linux系统信息命令
uname -r  # 查看当前系统内核版本
cat /boot/grub/grub.cfg | grep "menuentry 'Ubuntu"  # 查看系统所有可用内核版本
head -n 1 /etc/issue # 查看操作系统版本，是数字1不是字母L
cat /proc/cpuinfo # 查看CPU信息的linux系统信息命令 
hostname # 查看计算机名的linux系统信息命令
lsmod # 列出加载的内核模块
env # 查看环境变量资源  
cat /proc/loadavg  # 查看系统负载磁盘和分区
df -h  # 查看各分区使用情况 
du -sh  # 查看指定目录的大小
free -m  # 显示内存分配与交换层分配
grep MemTotal /proc/meminfo  # 查看内存总量 
grep MemFree /proc/meminfo  # 查看空闲内存量
uptime  # 查看系统运行时间、用户数、负载
mount | column -t  # 查看挂接的分区状态 
fdisk -l  # 查看所有分区 
swapon -s  # 查看所有交换分区 

rm -d [目录名]  # 删除一个空目录
rmdir [目录名]  # 删除一个空目录
rm -r [目录名]  # 删除一个非空目录
rm [文件名]  # 删除文件
sudo chmod u=r+w [filename].[filetype]  # 更改文件权限
tar -xf xxx.tar  # 文件解压
tar -zxvf XXX.tar.gz -C [指定目录]  # 安装tar.gz压缩包文件
ps -ef | grep 'xxx'  # 把ps查询结果通过管道给grep查找包含特定字符串的进程
ps -A  # 查看所有进程
ps -ef  # 查看进程
kill -s 9 1827  # 杀死1827这个进程
pgrep firefox  # 直接根据Firefox查询进程的PID
find ./* -type f -exec touch {} \;
find ./* -type d -exec touch {} \;


lspci | grep -i nvidia  # 查看pci连接设备型号 如nvidia显卡
ubuntu-drivers devices  # 查看设备对应推荐驱动型号
nvidia-smi  # 查看已安装的显卡驱动信息 需要安装nvidia显卡驱动
lspci -tv  # 列出所有PCI设备 
lsusb -tv  # 列出所有USB设备的linux系统信息命令 
hdparm -i /dev/hda  # 查看磁盘参数(仅适用于IDE设备)
dmesg | grep IDE  # 查看启动时IDE设备检测状况网络 
ifconfig  # 查看所有网络接口的属性 
iptables -L  # 查看防火墙设置 
route -n  # 查看路由表 
netstat -lntp  # 查看所有监听端口 
netstat -antp  # 查看所有已经建立的连接
sudo /etc/init.d/networking restart  # 更新网络
```



## 效率加速

[写给工程师的 Ubuntu 20.04 最佳配置指南 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/139305626)

### 更好的终端

#### vimplus安装

https://blog.csdn.net/qq_41962612/article/details/122883038

https://www.linuxprobe.com/vimide-env.html

https://blog.csdn.net/langxianwenye/article/details/17223807

#### zsh安装

[(28条消息) Ubuntu 20.04 安装zsh_CNRio的博客-CSDN博客](https://blog.csdn.net/dinofish/article/details/104452908/)

ZSH代表Z Shell，它是类Unix操作系统的shell程序。ZSH是Bourne Shell的扩展版本，结合了BASH，KSH和TSH的某些功能：

* 命令行完成。
* 可以在所有shell之间共享历史记录。
* 扩展文件匹配。
* 更好的变量和数组处理。
* 与bourne shell之类的shell兼容。
* 拼写更正和自动填充命令名称。
* 命名目录。
```bash
sudo aptitude install zsh  # 安装
zsh --version
# 配置
echo $SHELL
sudo chsh --shell $(which zsh) [username]
# 回到bash
sudo apt --purge remove zsh
sudo chsh --shell $(which "SHELL NAME") [username]

# 非ohmyzsh方法配置插件
# 启用ZSH Syntax Highlighting语法高亮显示插件
sudo aptitude install zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc 
# Powerline字体
# 「Powerline」是 ZSH Shell 的状态行插件，「Powerline 字体」也允许 ZSH 在 Shell 中使用不同的图标和符号。而「Powerline」和「Powerline 字体」也可以在 Ubuntu 18.04 LTS 的官方软件包存储库中找到
sudo aptitude install powerline fonts-powerline
sudo aptitude install zsh-theme-powerlevel9k
echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
```
#### oh-my-zsh

```shell
# 设置oh-my-zsh不读取文件变化信息
git config --add oh-my-zsh.hide-dirty 1
# 可以再设置oh-my-zsh不读取任何git信息
git config --add oh-my-zsh.hide-status 1
# 全局设置
git config --global oh-my-zsh.hide-status 1

```



#### 高效命令行

##### ffmpeg

FFmpeg是一个自由软件，可以运行音频和视频多种格式的录影、转换、流功能，包含了libavcodec——这是一个用于多个项目中音频和视频的解码器库，以及libavformat——一个音频与视频格式转换库。该软件可实现各种常用的各种音频格式转换。

```bash
# mp3转wav；wav转mp3
ffmpeg -i input.mp3 -f wav output.wav
ffmpeg -i input.wav -f mp2 output.mp3
```

##### locate&find

**locate** 让使用者可以很快速的搜寻档案系统内是否有指定的档案。其方法是先建立一个包括系统内所有档案名称及路径的数据库，之后当寻找时就只需查询这个数据库，而不必实际深入档案系统之中了。在一般的 distribution 之中，数据库的建立都被放在 crontab 中自动执行。

**find **命令是一个实时查找工具，通过遍历指定路径而完成对文件的查找；在使用该命令时，如果不选定参数，则在当前目录下查找子目录与文件并显示之；另外，任何位于参数之前的字符串，都将视为欲查找的目录名。由于是实时遍历查找，find有如下特性：精确实时查找，速度慢可能只搜索用户具备读取和执行权限的目录。

###### locate功能

locate命令可以在搜寻数据库时快速找到档案，locate为模糊查找，数据库由updatedb程序来更新，updatedb是由cron daemon周期性建立的，locate命令在搜寻数据库时比由整个由硬盘资料来搜寻资料来得快，但较差劲的是locate所找到的档案若是最近才建立或 刚更名的，可能会找不到，在内定值中，updatedb每天会跑一次，可以由修改crontab来更新设定值。(etc/crontab)

[Linux文件查找命令之locate与find | 《Linux就该这么学》 (linuxprobe.com)](https://www.linuxprobe.com/locate-and-find.html)

##### 挂载外存储设备

```bash
# mount ［-afFhnrvVw］ ［-L《标签》］ ［-o《选项》］ ［-t《文件系统类型》］ ［设备名］ ［加载点］
mount -t iso9660 /dev/cdrom /mnt/cdrom # 挂光驱
mount -t vfat /dev/fd0 /mnt/floppy # 挂软驱 (文件内型可以自己选)
sudo mount -o iocharser=utf8 /dev/sdb1 /media/usb # 解决linux系统默认挂载的Windows分区中文显示不正常；光驱中的中文也不能正常显示
```

### wget自动断点续传

有时候我们使用wget下载东西被迫打断, 比如网络故障, 终端意外断开, 忘了加"&"放入该台等等，
沉稳的人或许会想到重新开启wget, 并使用 -c断点续传
自动配置方法：

```bash
vim ~/.wgetrc
# 添加内容 continue = on
```
### Git加速与码云配置

#### 方法一: 修改系统配置文件

```bash
# 解决cannot download default sources list from以及其他外网打不开的问题
# 通过ICMP Internet控制消息协议方式直接获取接入本机的ip地址
ping github.global.ssl.fastly.net
ping github.com
ping raw.githubusercontent.com
# 找到/etc/[...]
# 根据格式输入后保存
# 69.63.184.30 github.global.ssl.fastly.net
# 20.205.243.166 github.com 
# 151.101.84.133 raw.githubusercontent.com
sudo vim /etc/hosts
# 刷新一下网络（其实主要是刷新DNS），再尝试下载
sudo /etc/init.d/networking restart
```

```bash
# Linux下，修改 ~/.pip/pip.conf (没有就创建一个文件夹及文件。文件夹要加“.”，表示是隐藏文件夹)
[global]
index-url=https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=mirrors.aliyun.com
# 临时使用时用pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pyspider
```

#### 方法二: ssh替代git

实际上还是网络协议问题，git支持多种协议，包括上面的https协议以及原生的ssh协议，git对ssh的支持是最好的，速度也是最快的，所以其实也可以改用ssh协议来clone

#### 方法三: gitee代替github
注册一个码云账号，然后将[github](https://so.csdn.net/so/search?q=github&spm=1001.2101.3001.7020)的库引入到自己的码云库中，然后两种方法：
1.git clone 自己的库。（直接clone可能速度慢）。
2.直接download .zip直接下载他的打包好的更快一些（经过测速得出，前提是你修改过hosts，并且网络顺畅）

##### 生成/添加SSH公钥

需要先配置好账户/仓库的SSH公钥

```bash
ssh-keygen -t rsa -C "XXXX@XXX.com" # 生成公钥
cat ~/.ssh/id_rsa.pub # 然后通过~/.ssh/id_rsa.pub查看public key，复制后通过[管理]->[部署公钥管理]->[添加部署公钥]->
# 选项1：添加生成public key到仓库，配置完成后会生成一个站点对应的文件夹，可以考虑用pull命令拉取代码
git init
git pull git@xxx/xxx.git
# 选项2：将电脑RSA公钥配置到码云上，进入[个人账号设置]，在设置页面中进入[SSH公钥]复制添加
git clone git@gitee.com:xxxx/xxx.git
```

[git和码云的使用 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1440321)

### 



### 软件源

设置位置：软件和更新 -> Ubuntu软件 -> 下载自

选择中国，可以点击"选择最佳服务器"，或可以使用指定镜像

**网易开源镜像站**
[http://mirrors.163.com/](https://link.zhihu.com/?target=http%3A//mirrors.163.com/)
**阿里云开源镜像站**
[https://mirrors.aliyun.com/](https://link.zhihu.com/?target=https%3A//mirrors.aliyun.com/)
**搜狐开源镜像站**
[http://mirrors.sohu.com](https://link.zhihu.com/?target=http%3A//mirrors.sohu.com)
**清华大学**
[https://mirrors.tuna.tsinghua.edu.cn](https://link.zhihu.com/?target=https%3A//mirrors.tuna.tsinghua.edu.cn)
**中国科技大学**
[http://mirrors.ustc.edu.cn](https://link.zhihu.com/?target=http%3A//mirrors.ustc.edu.cn)
**北京理工大学**
[http://mirror.bit.edu.cn/web/](https://link.zhihu.com/?target=http%3A//mirror.bit.edu.cn/web/)
**北京交通大学**
[https://mirror.bjtu.edu.cn/cn/](https://link.zhihu.com/?target=https%3A//mirror.bjtu.edu.cn/cn/)

```shell
# 命令行一键换源 可用于制作docker时使用
sudo sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

#### 第三方软件镜像
**iso镜像刻录神器(WoeUSB)**
WoeUSB是一款可以在Linux下把Window的系统镜像写入U盘的工具。类似于Windows 下的软碟通

```bash
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install woeusb
```

**Flatabulous 扁平化主题**
Ubuntu自带的主量实在的丑出翔了，下面是一个好看的扁平化主题

```bash
sudo add-apt-repository ppa:noobslab/themes
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install flatabulous-theme ultra-flat-icons
```
**OBS**
OBS是一个跨平台的录屏、直播神器，基本各大直播网站都可以用它来直播。同时支持Mac OSX、Linux和Windows。

```bash
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt-get update
sudo apt-get install obs-studio
```

**状态栏显示系统信息（System Moniter Indicator）**
可以在状态栏显示网速，内存使用率，CPU使用率等系统信息

```bash
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt update
sudo apt install indicator-sysmonitor
```

##### 删除添加的第三方源

### *软件源的重大威胁

[apt换各种源后都出现404错误问题解决 - 灰信网（软件开发博客聚合） (freesion.com)](https://www.freesion.com/article/8808228119/)
#### ***Canonical合作伙伴 is a snake***

### 手动建立一个桌面快捷方式

```bash
# 以pycharm快捷快捷方式为例
sudo gedit /usr/share/applications/pycharm.desktop
# 添加以下内容
[Desktop Entry]
Type=Application
Name=Pycharm
GenericName=Pycharm6                   #Pycharm后的数字无所谓，跟下面统一就好
Comment=Pycharm6:The Python IDE
Exec="[path-of-sh]" %f         #找到xxx.sh的绝对路径
Icon=[path-of-icon]          #找到xxx.png的绝对路径
Terminal=pycharm
Categories=Pycharm;
# 添加可执行权限
sudo chmod +x /usr/share/applications/pycharm.desktop
# 然后将桌面快捷方式pycharm.desktop复制到桌面
```

### 双系统时间不一致

https://wenku.baidu.com/view/6a95bf051a2e453610661ed9ad51f01dc2815788.html

http://wjhsh.net/bluestorm-p-4899274.html

# Windows

## 安装

[在现有Ubuntu系统上安装Windows 10 （双系统）](https://blog.csdn.net/weixin_39278265/article/details/90475070)

## Cmd

目录中快速进入cmd：直接在路径搜索栏中键入cmd

### 磁盘管理

```cmd
diskpart # 进入磁盘管理界面
list disk # 罗列当前挂载磁盘（物理驱动器）
sel disk 0 # 选择0号磁盘
list partition # 在当前挂载的磁盘上操作，罗列磁盘分区
sel disk 2 # 选择2号分区
delete partition override # 在当前磁盘分区下进行操作，删除当前磁盘分区
```

## 美化

[Win10主题 - Win10电脑主题 - Win10桌面主题 - 致美化 - 漫锋网 (zhutix.com)](https://zhutix.com/tag/win10-zhuti/?post_order=views)

[桌面美化之 windows10 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/102859469)

## 版本冲突与共存

### Java

#### Java7和Java8的自由切换

[(12条消息) Java7和Java8的自由切换（Win10）_fishwinwin的博客-CSDN博客](https://blog.csdn.net/qq_25353433/article/details/83823286)

## 搭配鸿蒙系统

[(13条消息) 非华为PC安装华为电脑管家，免积分下载_宥小稚的博客-CSDN博客_华为电脑管家](https://blog.csdn.net/guanxiaozhi/article/details/118305167)

## 错误代码

#### 错误代码0x80070003

[Windows 11 系统无法更新，错误代码：0x80070003](https://zhuanlan.zhihu.com/p/457775349)

[windows11升级失败0x80070003错误某些更新文件缺失或出现问题。我们将尝试稍后重新下载更新](https://zhuanlan.zhihu.com/p/586955701)

我是在windows10上遇到的问题,原因应该和双系统的引导有关,windows无法正常完成日常更新导致无法再进行更新,最终gg

# WSL

[全网最详细搭建Win10+WSL2+Ubuntu-22.04LTS+CUDA+Xfce4+noVNC个人工作站](https://blog.csdn.net/weixin_47145054/article/details/129865298)

[WSL2的安装与配置（创建Anaconda虚拟环境、更新软件包、安装PyTorch、VSCode）](https://blog.csdn.net/weixin_44878336/article/details/133967607)

[【2022】Windows 11/10开机自启动 WSL下的服务](https://blog.csdn.net/ehpuacm/article/details/125051372)

[Win10 系统安装 Linux 子系统教程(WSL2 + Ubuntu 20.04 + Gnome 桌面 ）](https://blog.csdn.net/FSKEps/article/details/118493578)

[win10下同时使用wsl1 和wsl2 子系统，提升开发效率](https://www.cnblogs.com/tccxy/p/16197894.html)

[Win10的Linux子系统Ubuntu使用串口](https://zhuanlan.zhihu.com/p/343013801#:~:text=Win10%E7%9A%84%E4%B8%B2%E5%8F%A3%EF%BC%8C%E5%8F%AF%E4%BB%A5%E7%9B%B4%E5%9C%A8WSL%E4%B8%AD%E6%8E%A5%E4%BD%BF%E7%94%A8%E3%80%82%20%E4%BB%8Ewindows,COM%E7%AB%AF%E5%8F%A3%E5%88%B0Linux%20tty%E6%8E%A5%E5%8F%A3%E4%B9%8B%E9%97%B4%E6%9C%89%E4%B8%80%E4%B8%AA%E7%AE%80%E5%8D%95%E7%9A%84%E6%98%A0%E5%B0%84%EF%BC%8C%E5%8D%B3COMx%E6%98%A0%E5%B0%84%E5%88%B0ttySx%EF%BC%8C%E4%BE%8B%E5%A6%82COM3%E5%AF%B9%E5%BA%94WSL%E4%B8%AD%E7%9A%84%E8%AE%BE%E5%A4%87%E5%90%8D%E7%A7%B0%2Fdev%2FttyS3%E3%80%82%20%E5%9C%A8WSL2%E7%89%88%E6%9C%AC%E4%B8%AD%EF%BC%8C%E7%A1%AC%E4%BB%B6%E8%AE%BF%E9%97%AE%E6%94%AF%E6%8C%81%E5%B0%86%E5%8F%97%E5%88%B0%E9%99%90%E5%88%B6%EF%BC%8C%E4%BE%8B%E5%A6%82%EF%BC%9A%E6%82%A8%E5%B0%86%E6%97%A0%E6%B3%95%E8%AE%BF%E9%97%AEGPU%E3%80%81%E4%B8%B2%E8%A1%8C%E6%88%96USB%E8%AE%BE%E5%A4%87%E3%80%82)

[Windows 11/10 WSL2 Ubuntu 20.04 下配置Cuda及Pytorch](https://blog.csdn.net/iwanvan/article/details/122119595)

# 虚拟机

## VirtualBox

[Linux_Downloads – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)

[(28条消息) VirtualBox安装教程及使用（Windows）_邵奈一的博客-CSDN博客](https://blog.csdn.net/shaock2018/article/details/103598635)

#### 安装系统

[(28条消息) 【珍藏版】VirtualBox虚拟机安装Windows10，妈妈看了都会说好丝滑~_virtualbox win10_桃山楂的博客-CSDN博客](https://blog.csdn.net/weixin_53345287/article/details/124651143)

[(28条消息) 使用VirtualBox安装Ubuntu虚拟机 - 完整教程-CSDN博客](https://blog.csdn.net/Amentos/article/details/127733864)

#### 网络连接问题

[(28条消息) Win10系统中VirtualBox网络桥接与主机直链同一wifi局域网互通并可连接外网_visual box 仅主机和桥接同时_神神的蜗牛的博客-CSDN博客](https://blog.csdn.net/zhouzme/article/details/80663432#:~:text=开始菜单 -> 设置 -> 网络和Internet -> 状态面板中 有个,wifi 连接 WLAN%2C 一个是刚刚设置的虚拟机的 host only 连接%2C 如下图%3A)

[(28条消息) 当笔记本是无线连接网络时，如何正确配置virtualbox的上网问题_强哥之神的博客-CSDN博客](https://blog.csdn.net/qianggezhishen/article/details/45841723)

## deepin_in_wine

```bash
https://packages.deepin.com/deepin/pool/non-free/d/deepin.com.wechat/deepin.com.wechat_2.6.2.31deepin0_i386.deb
sudo dpkg -i deepin.com.wechat_2.6.2.31deepin0_i386.deb
wget -qO- https://deepin-wine.i-m.dev/setup.sh | sudo sh # 启动wechat
sudo apt-get install com.qq.weixin.deepin
```

```bash
# 在ubuntu 上串口识别为ttyS0或ttyUSB0之类，在wine上识别不到，可用：
sudo ln -s /dev/ttyUSB0 ~/.wine/dosdevices/COM1
sudo chmod 777 ~/.wine/dosdevices/COM1
```

# PE OS

U 盘启动盘制作工具

[GitHub - ventoy/Ventoy: A new bootable USB solution.](https://github.com/ventoy/Ventoy)

## Ventoy

Ventoy是一款国人开发的新一代多ISO启动引导程序，这款工具最大的优点就是无需格式化优盘，用户只需要将所需的ISO镜像文件拷贝至优盘中即可在Ventoy界面中选择自己想要的ISO镜像文件

Ventoy 是一个制作可启动 U 盘的开源工具。 有了 Ventoy 你就无需反复地格式化 U 盘，你只需要把 ISO/WIM/IMG/VHD(x)/EFI 等类型的文件直接拷贝到 U 盘里面就可以启动了，无需其他操作。 你可以一次性拷贝很多个不同类型的镜像文件，Ventoy 会在启动时显示一个菜单来供你进行选择 (参见 截图)。 你还可以在 Ventoy 的界面中直接浏览并启动本地硬盘中的 ISO/WIM/IMG/VHD(x)/EFI 等类型的文件。

[(22条消息) Ventoy主题美化，以及自行制作方法_寒墨茗殇的博客-CSDN博客](https://blog.csdn.net/qq_40591925/article/details/128659273)

[(22条消息) 玩转系统|Ventoy – 免格式化，超简单的『多合一』系统启动盘制作神器_Jum朱的博客-CSDN博客_ventoy 数据持久化](https://blog.csdn.net/qq_22903531/article/details/128578416)

**VHD BOOT HOST VOLUME NOT ENOUGH SPACE问题**

解开VHD设置的静态存储后的总占用不得超过本身的存储容量

[使用VHD開機(Boot from VHD)的錯誤狀況 - 蘇老碎碎唸 (askasu.idv.tw)](https://www.askasu.idv.tw/archives/2247)

## Linux_to_go

安装完成后，启动 VirtualBox 中的虚拟电脑，进入 ubuntu2004 操作系统，然后下载 vtoyboot 脚本，这一步是为了在系统中做一些处理，以支持 Ventoy 启动。

[Releases · ventoy/vtoyboot (github.com)](https://github.com/ventoy/vtoyboot/releases)

下载的是 vtoyboot.xxx.iso 文件，解压得到 vtoyboot.sh 脚本文件，然后以 root 权限执行里面的脚本 `sudo bash vtoyboot.sh` ，执行成功后关机。

## Win_to_go

通过virtualbox以专业模式创建windows虚拟机，并保存为vhd格式，通过插件让Ventoy加载

[Release vhdimg v3.0 release · ventoy/vhdiso · GitHub](https://github.com/ventoy/vhdiso/releases/tag/v3.0)

#### 疑难解答

###### Q1. 因为硬件配置本身的原因使得无法安装系统如何解决

虽然有更改注册表的方法在低配置的设备上通过安装，但是并不建议这么做，因为不适合的配置会引发后续的诸多问题。

```powershell
# 在进行镜像安装时，Win11 会提示“该电脑无法运行 Win11”。
# 按 Shift+F10，打开命令行界面，输入 
regedit 
# 打开注册表，然后定位到 
HKEY_LOCAL_MACHINE\SYSTEM\Setup
# 创建一个名为“LabConfig”的项，接着在“LabConfig”下创建两个 DWORD 值(32位)：
Key: BypassTPMChcek
value: 00000001
Key: BypassSecureBootCheck
value: 00000001
Key: BypassCPUCheck
value: 1
Key: BypassRAMCheck
value: 1 
```

