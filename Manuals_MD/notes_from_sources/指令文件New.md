# 终端操作

```shell
  ~/.bash_profile  # 这个是用户环境变量配置文件
  /etc/profile  # 系统环境变量配置文件

  source ~/.bashrc
  source /opt/ros/melodic/setup.bash
  free -m #显示内存分配与交换层分配
  lspci | grep -i nvidia #查看显卡型号
  sudo chmod u=r+w <filename>.conf 更改文件权限
  sudo /etc/init.d/networking restart 更新网络

  sudo rm /var/cache/apt/archives/lock
  sudo rm /var/lib/dpkg/lock # 强制解锁
  ps -e | grep apt # 把ps查询结果通过管道给grep查找包含特定字符串的进程

  uname -a 查看系统版本和架构
  rosdep install --from-paths src --ignore-src -r -y

  ubuntu-drivers devices 
  nvidia-smi 查看显卡驱动信息
  uname -a # 查看内核/操作系统/CPU信息的linux系统信息命令
  cat /proc/version # 查看系统信息
  cat /proc/cpuinfo # 查看CPU
  head -n 1 /etc/issue # 查看操作系统版本，是数字1不是字母L 
  cat /proc/cpuinfo # 查看CPU信息的linux系统信息命令 
  hostname # 查看计算机名的linux系统信息命令 
  lspci -tv # 列出所有PCI设备，lspci 可以查看到北桥、显卡(VGA)、声卡(Audio device)、PCI接口、USB接口及网卡(Ethenet)等
  lspcic | grep -i host\ bridge # 北桥MCh
  lspci | grep -i interface # 南桥ICH
  lsusb -tv # 列出所有USB设备的linux系统信息命令 
  lsmod # 列出加载的内核模块 
  env # 查看环境变量资源 
  free -m # 查看内存使用量和交换区使用量 
  df -h # 查看各分区使用情况 
  du -sh # 查看指定目录的大小 
  grep MemTotal /proc/meminfo # 查看内存总量 
  grep MemFree /proc/meminfo # 查看空闲内存量 
  uptime # 查看系统运行时间、用户数、负载 
  cat /proc/loadavg # 查看系统负载磁盘和分区 
  mount | column -t # 查看挂接的分区状态 
  fdisk -l # 查看所有分区 
  swapon -s # 查看所有交换分区 
  hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备) 
  dmesg | grep IDE # 查看启动时IDE设备检测状况网络 
  ifconfig # 查看所有网络接口的属性 
  iptables -L # 查看防火墙设置 
  route -n # 查看路由表 
  netstat -lntp # 查看所有监听端口 
  netstat -antp # 查看所有已经建立的连接 
 
  export PATH=$PATH:/path/to/your/dir  # 加到PATH末尾
  export PATH=/path/to/your/dir:$PATH  # 加到PATH开头

  ps -A # 查看所有进程
  ps -ef # 查看进程
  kill -s 9 1827 # 杀死1827这个进程
  pgrep firefox # 直接根据Firefox查询进程的PID
  free -m # 查看内存和交换区的使用情况
  htop # 左上角显示CPU、内存、交换区的使用情况，右边显示任务、负载、开机时间，下面就是进程实时状况。F9可移除等等。每个条目都支持四种显示方式：Text、Bar、Graph、LED，注意右上角分别显示了这四种效果。其他操作基本和在Windows下设置BIOS是一样的，另外这里都是支持鼠标操作的。要想显示进程的树形结构，可以输入"t"或按下F5，功能类似于pstree命令。最后一行是F1~F10的功能菜单和对应的字母快捷键
  sync # 同步一下，强行将交换区的内容保存到内存
  echo 3 > /proc/sys/vm/drop_caches 
  swapoff -a # 关闭交换区
  swapon -a # 重启交换区
  
  # dmidecode, 使用该命令可以查询BIOS、系统、主板、处理器、内存、缓存等非常重要信息
  dmidecode | grep 'Product Name'                          # 查看服务器型号
  dmidecode | grep 'Serial Number'                        # 查看主板的序列号
  dmidecode -s system-serial-number                       # 查看系统序列号
  dmidecode -t memory                                         # 查看内存信息
  dmidecode -t 11                                              # 查看OEM信息
  dmidecode | grep -A16 "Memory Device" | grep "Size" |sed 's/^[ \t]*//' # 现有内存数量和内存大小
  dmidecode | grep "Maximum Capacity" |sed  "s/^[ \t]*//"                    # 最大支持内存容量
  
  tree -I "node_modules" # -I 忽略某个目录内容
```

# tar

```shell
tar -xf xxx.tar # 文件解压
tar -zxvf XXX.tar.gz -C /指定目录 # 安装tar.gz压缩包文件
```
# rm操作

```shell
 rm -d 目录名              #删除一个空目录
  rmdir 目录名              #删除一个空目录
  rm -r 目录名              #删除一个非空目录
  rm 文件名                  #删除文件
```

# vi操作

  :i 插入模式

  跳到文本的最后一行：按“G”,即“shift+g”

  跳到最后一行的最后一个字符 ： 先重复1的操作即按“G”，之后按“$”键，即“shift+4”。

  跳到第一行的第一个字符：先按两次“g”，

  跳转到当前行的第一个字符：在当前行按“0”。

  按 ESC 退出 插入模式

  :w 保存但不退出

  :wq 保存并退出

  :q 退出

  :q! 强制退出，不保存

  :e! 放弃所有修改，从上次保存文件开始再编辑命令历史

  vim -c cmd file: 在打开文件前，先执行指定的命令；
  vim -r file: 恢复上次异常退出的文件；
  vim -R file: 以只读的方式打开文件，但可以强制保存；
  vim -M file: 以只读的方式打开文件，不可以强制保存；
  vim -y num file: 将编辑窗口的大小设为num行；
  vim + file: 从文件的末尾开始；
  vim +num file: 从第num行开始；

  tips：

     vim中 E212：无法打开并写入文件 的解决办法
      保存文件时用  : w ! sudo tee % ，tee 用于读取输入文件，同时保存
     %表示当前编辑文件 
    
     按8，再按i，进入插入模式，输入=， 按esc进入命令模式，就会出现8个=。 
     这在插入分割线时非常有用，如30i+<esc>就插入了36个+组成的分割线。
    
      保存的时候可以指定路径：
      :write sth/file.cpp
      这样把文件保存到相对路径sth/下。你也可以使用绝对路径。

# apt

```shell
  sudo apt-get update #更新源

  sudo apt-get install package #安装包

  sudo apt-get remove package # 删除包

  sudo apt-cache search package # 搜索软件包

  sudo apt-cache show package #获取包的相关信息，如说明、大小、版本等

  sudo apt-get install package –reinstall #重新安装包

  sudo apt-get -f install #修复安装

  sudo apt-get remove package –purge #删除包，包括配置文件等

  sudo apt-get build-dep package #安装相关的编译环境

  sudo apt-get upgrade #更新已安装的包

  sudo apt-get dist-upgrade #升级系统

  sudo apt-cache depends package #了解使用该包依赖那些包

  sudo apt-cache rdepends package #查看该包被哪些包依赖

  sudo apt-get source package #下载该包的源代码

  sudo apt-get clean && sudo apt-get autoclean #清理无用的包

  sudo apt-get check #检查是否有损坏的依赖

  apt --fix-broken install
```

# dpkg

```shell
dpkg -i file name.deb # 安装软件 命令行

dpkg -C # 查找只有部分安装的软件包信息

dpkg –compare-versions ver1 op ver2 # 比较同一个包的不同版本之间的差别

dpkg –licence (or) dpkg –license # 显示dpkg的Licence 命令行

dpkg –version # 显示dpkg的版本号

dpkg -l package-name-pattern # 搜索Deb 命令行

dpkg -l # 显示所有已经安装的Deb包，同时显示版本号以及简短说明

dpkg -p package-name # 显示包的具体信息
```

# python

```shell
pip list # 显示python下的包，进入python查看安装路径 import sys  sys.path
python --version # 查看版本
update-alternatives --list python # 查看可切换的版本
update-alternatives --config python # 切换版本
env | grep ROS # ros和python对应
env | grep PY
pkg-config opencv --libs # 查看opencv
export | grep ROS # 查看环境变量
whereis python
pip list
pip install django_celery_beat -i https://pypi.tuna.tsinghua.edu.cn/simple/ # 临时使用清华
source .virtualenvs/my_project/bin/activate # 在Linux使用pycharm架构下的虚拟环境
pip show numpy # 查看pip安装的软件包路径
pydoc modules # 效果同python解释器环境下输入 help("modules")
# 安装过yolk模块时
yolk -l    #列出所有安装模块
yolk -a    #列出激活的模块
yolk -n    #列出非激活模块
yolk -U [packagename]  # 通过查询pypi来查看（该）模块是否有新版本
# 安装过conda时
conda deactivate # 退出conda虚拟环境
```

```python
import pip
installed_packages = pip.get_installed_distributions()
installed_packages_list = sorted(["%s==%s" % (i.key, i.version)
     for i in installed_packages])
print(installed_packages_list)
```



# Kazam

  开始录屏 SUPER-CTRL-R

  结束录屏 SUPER-CTRL-F

  暂停录屏:SUPER-CTRL-P

  退出录屏:SUPER-CTRL-Q

  mplayer -ao null `XXX`.mp4 -vo jpeg:outdir=./`XXX` MP4转jpg

  convert ./tabs/*.jpg view.gif jpg转gif

# ros讲

  传感器的过于多样———兼容（软件配置）
  ros产生一个框架（包的可移植）
  ps.机器人的硬件问题
  实施性问题，消息传递的同时传递时间戳（系统时间）
  参数共享问题，启用参数服务器
  service和topic：申请于否
  消息发布与算法处理时间（程序的可实施性）
  api 函数格式 rqt_graph
  rqt_plot 根据数据绘制曲线
  rosbag package 记录和回放ros主题与执行过程
  tf消息（tf数）关节与关节之间的相对关系（自动计算在world内的数据）
  三维空间内的刚体运动 *转动——*四元数（重点）与欧拉角
  SLAM无人小车 室内单位导航跟踪（有边用激光雷达的地图，无边室外GPS类）
  先建图再导航
  move_baes全局规划和局部规划（两份“地图”）
  amcl蒙特卡洛定位？包（何处点数目多，往部分挤） 内部参数会影响定位效果（重合的效果是否好）
  运动规划前的测算（陀螺仪直接测得速度角速度～多用于机械臂，激光雷达测点云两次建图比较、kinect深度探测点云数据）
  导航和运动规划需要实战 长廊效应：无限远的空间，无法定位和计算相对唯一（一般需要陀螺仪和雷达地图相配合，此时雷达地图失效，误差大）
  rviz的显示（需要类WIFI？）
  障碍路径的膨胀系数
  Maker代表一个点或线，将速度角速度绘制成长度，两个绿箭头导航原点和目标点
  世界坐标系选择地图：fixed frame

--exclude=/boot --exclude=/root.tgz /

备份整个系统文件不仅是为了以后恢复系统方便，也可以用来直接克隆出一个系统来直接使用。


  linux-headers-4.15.0-72-generic 4.15.0-72.81

思考：
./ 的含义 #当前目录，.是代表此目录本身，但是一般可以不写 所以cd ~/. 和cd ~ 和cd ~/效果是一样的
~/ 的含义 #根目录，当前登录用户的用户主文件夹，而/root是root用户的主目录
./.local 中 local 前面的那个 . 的含义 #.英文点号表示这是个隐藏文件或隐藏文件夹

查看 $PATH 变量，然后思考你平时运行的pip 的绝对路径是在哪里，执行 which pip 验证你的想法。

思考 pip install --user 会把包安装到哪里，不加 --user 会把包安装到哪里，思考为什么不加 --user 需要 sudo 权限

chmod +x talker.py

无法定位的包：libfreenect  hokuyo-node

# Git

```shell
git clone
git status
git branch xxx
git branch -b xxx
git checkout xxx
git add xxx
git commit -m 'xxx.'
git checkout -b branch-name origin/branch-name # 在本地创建和远程分支对应的分支，已知远程分支情况
git branch --set-upstream-to branch-name origin/branch-name # 本地分支和远程分支的链接关系没有创建时，使用此命令进行修复

git remote # 查看远程库信息
git remote -v # 查看远程库更详细信息

git push -u origin master 
git push origin xxx
git merge xxxbranch # Fast Forwaed模式合并分支
git merge --no-ff -m "xxx." xxxbranch # 以普通模式合并分支
git log --graph --pretty=oneline --abbrev-commit
git stash # save current working directory and index state
git stash list
git stash pop # 恢复工作现场内容并删除贮藏的临时现场
git stash apply stash@{[index]} & git stash drop # 等效于git stash pop

git pull # 远程抓取分支，并手动处理冲突
git tag -a tag-name -m "message-context" commit-id # 打标签用-a指定标签名，用-m指定说明文字
git show tagname # 查看标签信息
git tag -d tag-name
git push origin tag-name
git push origin --tags # 一次性推送全部尚未推送到远程的本地标签

git config --global alias.xx xxx # 配置别名
git unstage xxx.file # 配置别名过后，用于撤回暂存区的修改 alias.unstage=reset HEAD
```

**master->dev->'someone'->xxx**

* master分支应该是十分稳定的，不能拿来做测试
* master分支是主分支，应该与远程时刻保持同步
* dev是团队开发分支，团队成员都需要在上面工作，也需要保持同步
* bug分支
* feature分支

**GitLab权限（从低到高）**

* Guest
* Reporter
* Developer
* Maintainer
* Owner

**.gitignore**

编写配置文件用于处理文件忽视

# MetroDesign

更新内核带来的驱动失效问题（内核锁定解决 进行hold）

#!/usr/bin/sh

sudo apt-get install curl gnupg apt-transport-https -y

## Team RabbitMQ's main signing key
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Launchpad PPA that provides modern Erlang releases
curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null
## PackageCloud RabbitMQ repository
curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null

## Add apt repositories maintained by Team RabbitMQ
sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
## Provides modern Erlang/OTP releases
##
## "bionic" as distribution name should work for any reasonably recent Ubuntu or Debian release.
## See the release to distribution mapping table in RabbitMQ doc guides to learn more.
deb [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main

## Provides RabbitMQ
##
## "bionic" as distribution name should work for any reasonably recent Ubuntu or Debian release.
## See the release to distribution mapping table in RabbitMQ doc guides to learn more.
deb [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main
deb-src [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main
EOF

## Update package indices
sudo apt-get update -y

## Install Erlang packages
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing

  service rabbitmq-server stop # 停止MQ服务
  service rabbitmq-server start # 开启MQ服务
  service rabbitmq-server status # 查看服务状态
  rabbitmq-plugins enable rabbitmq_management # 开启web管理插件
  systemctl stop firewalld # 关闭防火墙
  root@airlo-F117-V:/home/airlo# rabbitmqctl add_user admin admin（只有root下才可以）
  root@airlo-F117-V:/home/airlo# rabbitmqctl add_user admin pxy
  Adding user "admin" ...
  Done. Don't forget to grant the user permissions to some virtual hosts! See 'rabbitmqctl help set_permissions' to learn more.

  service postgresql status # 检查PostgreSQL是否在运行
  Usage: /etc/init.d/postgresql {start|stop|restart|reload|force-reload|status} [version ..]


#################
#################
#################
#PostgreSQL

$ apt show postgresql # 查看可用postgresql版本
Package: postgresql
Version: 14+238.pgdg18.04+1
Priority: optional
Section: database
Source: postgresql-common (238.pgdg18.04+1)

$ sudo su postgres
$ psql
postgres=#
postgres=# CREATE USER airlo000 WITH PASSWORD 'airlo000';
CREATE ROLE
postgres=# \du
                             角色列表
 角色名称 |                    属性                    | 成员属于 
----------+--------------------------------------------+----------
 airlo000 |                                            | {}
 postgres | 超级用户, 建立角色, 建立 DB, 复制, 绕过RLS | {}

postgres=# ALTER USER airlo000 WITH SUPERUSER;
ALTER ROLE
postgres=# \du
                             角色列表
 角色名称 |                    属性                    | 成员属于 
----------+--------------------------------------------+----------
 airlo000 | 超级用户                                   | {}
 postgres | 超级用户, 建立角色, 建立 DB, 复制, 绕过RLS | {}
postgres=# \q
postgres@airlo-F117-V:/home/airlo$ ^C

sudo -u postgres psql # 直接登录**

tree -I "static|__pycache__|migrations"
