# Minecraft

## Commands

### 生存实用

#### 死亡不掉落

开启：/gamerule keepInventory true

关闭：/gamerule keepInventory false

查询：/gamerule keepinventory

#### 防爆

/gamerule mobGriefing False

#### 重设出生点

/spawnpoint

## 运行诊断

客户端的CrashReport文件夹目录：(.minecraft\crash-reports)

如果你启用了版本隔离，那就在(.minecraft\versions\xxxx\crash-reports)

服务端的CrashReport在你的服务端根目录下。

[来看懂 游戏《Minecraft》的崩溃报告吧！ 服务端/客户端 - 田所浩托TrosuoTro - 博客园 (cnblogs.com)](https://www.cnblogs.com/Dinnerbone/p/12045117.html)

安装forge失败：

[downloading minecraft server failed, invalid e-tag cheksum. Try again or manually place server jar to skip download. - Support & Bug Reports - Forge Forums (minecraftforge.net)](https://forums.minecraftforge.net/topic/64480-downloading-minecraft-server-failed-invalid-e-tag-cheksum-try-again-or-manually-place-server-jar-to-skip-download/)

java虚拟机运行内存不足：

[java虚拟机内存不足，“Could not create the Java Virtual Machine”问题解决方案 - 天际霄鹰 - 博客园 (cnblogs.com)](https://www.cnblogs.com/tianjixiaoying/p/4414254.html)

## MODS

### 材质和光影

#### OptiFine

官网网址：[OptiFine](https://www.optifine.net/home)

OptiFine is a Minecraft optimization mod.

It allows Minecraft to run faster and look better with full support for HD textures and many configuration options.

The official OptiFine description is on the [Minecraft Forums](http://www.minecraftforum.net/topic/249637-).

## Server

### 服务器常识

### 分类

#### Minecraft_Server

官方服务端，不能安装插件。可以安装Forge加载各种MOD

#### CraftBukkit

俗称水桶服，可以安装插件，不可以安装Forge。

#### Spigot

俗称水龙头，可以安装插件，是CraftBukkit优化版，支持CraftBukkit大部分插件.(有待补充特殊功能)

### 服务器插件

CraftBukkit,Spigot,Cauldron(MCPC)服务端添加插件：

插件是根据JavaDoc提供的类、方法、接口实现的Java程序。插件获取途径有很多，可以去各个社区下载。将下载的插件(***.jar)放进服务端插件文件夹(./plugins)，重启服务器即可。

很著名的“起床战争”就是一个可以在水桶服与水龙头服上运行的插件。

### 服务器模组

mod是关于游戏内容的补充，可以是增加游戏内容，可以是改善游戏画面和方式，mod可以添加在单人游戏里，也可以添加在服务器里。插件是针对水桶服务器（bukkit）运行特殊功能的补充，它是用来增加服务器的功能而不是增加游戏内容，插件可以是增加服务器的稳定性比如防作弊防透视，可以是让服务器拥有NPC或竞技场，插件不能在单人游戏里使用。

mod需要forge等支持运行，而且有可能有严重的mod冲突，冲突的主要原因是物品代码冲突。

### 搭建服务器流程

#### 1. 安装Java

#### 2. 下载forge

forge官网：http://files.minecraftforge.net/

下载对应Minecraft版本的forge

#### 3. 下载Minecraft服务端

MC正版启动器，在“启动选项”中选择新建选择想要下载的版本，点击下载服务端

#### 4. 安装forge

将下载好的forge和服务端放在同一个目录下，修改服务端的文件名为 **minecraft_server.xxx.jar**
xxx为版本号

打开CMD,执行 **java -jar [forge安装包文件名] --install** 开始安装

#### 5. 启动服务端

执行 **java -jar forge-1.12.2-14.23.5.2768-universal.jar -Xmx4096M -Xms4096M -serve** 启动服务端Xmx和Xms中的数字是最大最小内存。

生成了一个eula.txt，把其中的false改成true，然后再启动服务端

启动成功后，可以用客户端连接了，端口默认为25565，可以通过修改server.properties文件修改端口。启动服务端后会生成几个目录，mods为存放mod的目录，world为世界存档，删除world后重新启动服务端会重新生成世界。
