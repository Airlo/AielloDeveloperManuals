# python

## 虚拟环境工具[Anaconda.org](https://anaconda.org/)

官网下载安装：[Anaconda | Anaconda Distribution](https://www.anaconda.com/products/distribution)



#### 基本指令

[conda的安装与使用 2.0版（2022-08-12更新） - 简书 (jianshu.com)](https://www.jianshu.com/p/edaa744ea47d)

```powershell
# 查看可激活的虚拟环境
conda info -e
conda env list
# 激活环境
conda activate ${your_env_name}
# 退出当前环境
conda deactivate
# 复制环境,局限于conda install安装,跳过pip install安装部分
conda create -n ${new_env_name} --clone ${now_env_name}
# 导出环境(无法直接跨不同系统,起码win11到linux不行,需要把多余包删去)
conda env export --name ${env_name} > environment.yaml 
# 导入环境
conda env create -f environment.yaml
```

conda环境跨平台迁移问题ResolvePackageNotFound

```shell
# 1. 清除定制版本信息
# 手动清除dependencies里的版本制定信息（platform-specific build constraints）
sed 's/\\(.\*[[:alnum:]]\\)=[[:alnum:]][[:alnum:].-\_]\*/\\1/' environment.yaml > env.yml
# 导出时自动忽略构筑信息
conda env export --name ${env_name} --no-builds > environment.yml
```

[Anaconda is a snake. (qq.com)](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247486380&idx=1&sn=9329fcd0a60ac5488607d359d6c28134&chksm=9b484b17ac3fc20153d25cbdefe5017c7aa9080d13b5473a05f79808244e848b0a45d2a6a735&scene=21#wechat_redirect)

[(12条消息) 解决Ubuntu16.04中Anaconda3和ROS对应Python版本矛盾的问题_王蛋糕cake的博客-CSDN博客](https://blog.csdn.net/qq_37194582/article/details/97648004)

[在anaconda3+Python3中使用rospy，以及pycharm无法引用rospy的问题 - 简书 (jianshu.com)](https://www.jianshu.com/p/0e17f1b66af9)

[关于ROS兼容的可能的解决方法](https://blog.csdn.net/Will_Ye/article/details/125546383)

PowerShell报错：无法加载文件C:\Users\server\Documents\windowsPowerShell\profile.ps1

```powershell
# PowerShell默认禁止运行脚本,需要以管理员身份设置
get-ExecutionPolicy
# 检查状态
set-ExecutionPolicy RemoteSigned
# 重启powershell
```

## jupyter notebook

Jupyter Notebook是基于网页的用于交互计算的应用程序。其可被应用于全过程计算：开发、文档编写、运行代码和展示结果。

使用[jupyter-themes](https://github.com/dunovank/jupyter-themes)来为jupyter notebook更改主题颜色(theme)：[ 更改jupyter notebook的主题颜色(theme) 包括pycharm_QZQmmmm的博客-CSDN博客_jupyter主题](https://blog.csdn.net/Techmonster/article/details/73382535)

## PyCharm

[Pycharm虚拟环境的使用:构建独立的开发环境 - 简书 (jianshu.com)](https://www.jianshu.com/p/b4629ee87e80)

[PyCharm配置数据库出现 No data sources are configured to run this SQL and provide advanced code assis... - 简书 (jianshu.com)](https://www.jianshu.com/p/77ce95b2bf0e)

## PIP

```bash
# 使用pip安装完包后，只需再执行一次命令pip install xx，就会显示安装路径
# 使用pip freeze命令可以查看安装了那些包
```

```python
# module 'pip' has no attribute 'xxx' 
import pip._internal
print(pip._internal.xxx.get_supported())
```

## PIPX

一个自由开源程序，允许你在隔离的虚拟环境中安装和运行 Python 应用

#### 安装与使用

```shell
sudo apt install python-pipx

# 将 pipx 虚拟环境下的 $PATH 加入到系统中
pipx ensurepath
```

```powershell
scoop bucket add pipx-standalone https://github.com/uranusjr/pipx-standalone.git
scoop install pipx

pipx ensurepath
```

```shell
# 安装指定包
pipx install ${PACKAGENAME}
# 查看已安装
pipx list
# 直接在 pipx 所管理的虚拟环境中运行 Python 开发的 CLI 工具，便于快速测试工具
pipx run pycowsay moooo!
```



## 疑难杂症

[pip - No matching distribution found for 'package' in python wheel - Stack Overflow](https://stackoverflow.com/questions/35389875/no-matching-distribution-found-for-package-in-python-wheel)

#### 版本升降问题

```shell
# 版本升降问题
pip show pip
python3 -m pip install --upgrade pip # 指定用系统的python3不指定版本升级pip
python3 -m pip install pip==9.0.1 # 指定用系统的python3指定版本升降级pip
```

#### 版本检查问题

#### 版本差异问题

##### python2和python3的特性差异

[python2和python3的差异](https://www.cnblogs.com/feifeifeisir/p/9599218.html)

[PYTHON2 和PYTHON3 打开文件注意事项](https://www.freesion.com/article/917980990/)

[python1-python3中sort函数key如何对两个参数做对比](https://www.cnblogs.com/tensorzhang/p/14646329.html)

[字符编码笔记：ASCII，Unicode 和 UTF-8](http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html)

#### cannot import name 'main'

![20180730145547369](./elements/20180730145547369.png)



#### Win环境变量

**powershell不能调用python指令，跳出ms store的解决**

删掉Path中的：%USERPROFILE%\AppData\Local\Microsoft\WindowsApps

# Solidworks

# node.js

https://blog.csdn.net/beidaol/article/details/81009740

[高级-Post请求实现](https://www.jb51.net/article/168927.htm)

[高级-Post请求实现2](https://blog.csdn.net/shiyong1949/article/details/72471294)

[高级-字符串解析](https://www.cnblogs.com/gutianer/p/6917548.html?utm_source=itdadao&utm_medium=referral)

[IDEA使用之JavaScripts](https://www.w3cschool.cn/intellij_idea_doc/intellij_idea_doc-17cm2ygy.html)

#### npm命令

```bash
npm init  # 初始化仓库自动创建package.json文件
npm install -save-dev  # 自动将package.json中的模块安装到当前路径的node-modules
npm install --dependencies  # 只安装package.json里的dependencies（运行依赖）文件
npm install --devDependencies  # 只安装package.json里的devDependencies（开发依赖）文件
npm install -g npm-check-updates  # 更新依赖包到最新版本
ncu  # 检查package.json中依赖包的最新版本
```



# CSS&Html

https://www.runoob.com/cssref/pr-text-text-align.html

https://www.runoob.com/jsref/dom-obj-document.html

# JAVA&JavaScripts

## Intelli IDEA

[maven是什么？ - 技术改变命运Andy - 博客园 (cnblogs.com)](https://www.cnblogs.com/andy0816/p/14294023.html)

[idea怎么配置maven - 技术改变命运Andy - 博客园 (cnblogs.com)](https://www.cnblogs.com/andy0816/p/14294002.html)

[(12条消息) Intellij IDEA创建SpringBoot项目（超详细）+Mybatis整合Ajax+Bootstrap前端学习增删改查_Superclovers_的博客-CSDN博客](https://blog.csdn.net/qq_41254299/article/details/108371771)

## Babel

Babel 是一个 JavaScript 编译器

https://www.babeljs.cn/docs/

## PIXIS

[PixiJS学习（5）几何图形](https://blog.csdn.net/xiechao_5800/article/details/103560051)

# C++

## 版本演变与支持检验

### 检测编译器对C++0x和C++11的支持

C++0x定义了：

```cpp
#define __cplusplus 1
#define __GXX_EXPERIMENTAL_CXX0X__ 1
```

C++11定义了：

```cpp
#define __cplusplus 201103L
#define __GXX_EXPERIMENTAL_CXX0X__ 1
```

C++14定义了：

```cpp
#define __cplusplus 201402L
#define __GXX_EXPERIMENTAL_CXX0X__ 1
```

所以，要检测是否c++11，则一般使用#if __cplusplus >= 201103L
如果失败再尝试使用**GXX_EXPERIMENTAL_CXX0X**来检测。

而对于C语言的宏，则可以通过以下形式来验证编译器支持。

```text
arm-linux-androideabi-gcc -dM -E - < /dev/null
```

### GCC编译器对C++11的特性支持

[C++ Standards Support in GCC - GNU Project](https://gcc.gnu.org/projects/cxx-status.html)

## g++、gcc和gdb

[(12条消息) ubuntu18.04安装gcc详细步骤（附问题集）_nandycooh的博客-CSDN博客_mpc-1.1.0.tar.gz](https://blog.csdn.net/weixin_42108484/article/details/83021957)

https://stackoverflow.com/questions/16886591/how-do-i-enable-c11-in-gcc

```bash
# 使用 g++-4.8 编译 C++11 的程序, 必须带上编译选项 -std=c++11
g++-4.8 -std=c++11 -g a.cpp -o a
# 升级到g++-11
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-11 
sudo apt-get install g++-11
```

### 调试助手

#### core dump

core的意思是：内存，dump的意思是：扔出来、堆出来。

开发和使用linux程序时，有时程序莫名其妙的down掉了，却没有任何的提示(有时候会提示core dumped)。

这时候可以查看一下有没有形如：**core** 的文件生成，这个文件便是操作系统把程序down掉时的内存的内容扔出来生成的，它可以做为调试程序的参考。

core dump又叫核心转储，当程序运行过程中发生异常，程序异常退出时，由操作系统把程序当前的内存状况存储在一个core文件中，叫core dump。**Linux系统可以产生core文件，配合gdb就可以解决这个问题**

```bash
# 第一步：让系统在信号中断造成的错误时产生core文件
ulimit -c unlimited  # 设置core大小为无限
ulimit unlimited  # 设置文件大小为无限
# 第二步：编译原来的程序
gcc -o xxx xxx.c -g
# 第三步：运行编译后的的程序用gdb查看core文件
gdb xxx core
gdb -c core xxx
# 第四步：输入bt或者where，就会出现错误的位置，就可以显示程序在哪一行dowm掉的，在哪个函数中down掉的

# ps.当上述ulimit指令无法将core生成到程序运行的所在目录时，大概率是因为/proc/sys/kernel/core_pattern中内容不对
# 临时修改：（在root用户权限下）
echo core > /proc/sys/kernel/core_pattern
```





## .so和.a

[(13条消息) error while loading shared libraries错误解决办法_vivian187的博客-CSDN博客](https://blog.csdn.net/vivian187/article/details/51134461)



# C#

## ASP.NET Core

ASP.NET Core 是一个跨平台的高性能[开源](https://github.com/dotnet/aspnetcore)框架，用于生成启用云且连接 Internet 的新式应用。

使用 ASP.NET Core，您可以：

- 生成 Web 应用和服务、[物联网 (IoT)](https://www.microsoft.com/internet-of-things/) 应用和移动后端。
- 在 Windows、macOS 和 Linux 上使用喜爱的开发工具。
- 部署到云或本地。
- 在 [.NET Core](https://docs.microsoft.com/zh-CN/dotnet/core/introduction) 上运行。

[ASP.NET 文档 | Microsoft Docs](https://docs.microsoft.com/zh-cn/aspnet/core/?view=aspnetcore-6.0)

# Edge

导入Chrome数据，包括收藏夹、扩展

数据多设备同步

将站点作为应用安装

大声朗读

阅读模式

自定义字体

删除重复收藏夹

项目集锦，收藏网页、文本和照片

保存集锦发送到Excel或Word、下载或以PDF格式下载

PDF阅读与批注

### 插件

#### 谷粒-Chrome插件英雄榜

[GitHub - zhaoolee/ChromeAppHeroes: 🌈谷粒-Chrome插件英雄榜, 为优秀的Chrome插件写一本中文说明书, 让Chrome插件英雄们造福人类~ ChromePluginHeroes, Write a Chinese manual for the excellent Chrome plugin, let the Chrome plugin heroes benefit the human~ 公众号「0加1」同步更新](https://github.com/zhaoolee/ChromeAppHeroes)

#### Saladict 文本/截图翻译

[技巧分享：Quicker 调用 Saladict 实现全局『文本翻译、截图翻译、复制翻译、触边翻译』 · Discussion #493 · crimx/ext-saladict (github.com)](https://github.com/crimx/ext-saladict/discussions/493)

# Android Studio

[Android 开发者  | Android Developers (google.cn)](https://developer.android.google.cn/)

### 安装

[(12条消息) Android Studio的安装，史上最详细(超多图)！！_iterhui的博客-CSDN博客_android studio](https://blog.csdn.net/qq_41976613/article/details/91432304)

# Typora

Typora 是一款**支持实时预览的 Markdown 文本编辑器**。它有 OS X、Windows、Linux 三个平台的版本，并且由于仍在测试中，是**完全免费**的。（2022已不再免费，但是为买断制）

Typora 首先是一个 Markdown 文本编辑器，它支持且仅支持 Markdown 语法的文本编辑。在 [Typora 官网](https://typora.io/) 上他们将 Typora 描述为 「A truly **minimal** markdown editor. 」。

[Typora 完全使用详解 - 少数派 (sspai.com)](https://sspai.com/post/54912)
### download
```bash
# or run:
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wegt -q0 https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
# add Typora's repository
sudo add-apt-repository 'deb https://typoraio.cn/linux ./'
sudo apt-get update
# install typora
sudo apt-get install typora
```

#### key
DPFRHZ-68BKXJ-XCNKHQ-PBAH8K

# DataBase

## SQLite

[(12条消息) SQLiteStudio使用教程_未来无限的博客-CSDN博客_sqlitestudio](https://blog.csdn.net/qq_30725967/article/details/90205186)

[SQL语句之查询（SELECT) - 西江逐月 - 博客园 (cnblogs.com)](https://www.cnblogs.com/fzxey/p/10883824.html#限定查询)

### 安全性

#### 设置密码

```sql
# 首先创建一个数据库连接
SQLiteConnection conn = new SQLiteConnection("Data Source=MyDatabase.sqlite;Version=3;");
# 使用SetPassword设置密码，并使用open方法打开数据库
conn.SetPassword("password");
conn.Open();
# 下一次访问此数据库的时候需要通过密码访问
conn = new SQLiteConnection("Data Source=MyDatabase.sqlite;Version=3;Password=password;");
# 改变密码使用ChangePassword
conn.ChangePassword("new_password");
# 如果想移除密码可以通过设置空密码来设置
conn.ChangePassword(String.Empty);
```

## Oracle

[Oracle数据库下载及安装图文操作步骤_oracle_脚本之家 (jb51.net)](https://www.jb51.net/article/32616.htm)

## PostgreSQL

数据库本体：https://www.postgresql.org/download/linux/ubuntu/

数据库可视化界面PgAdmin：https://www.pgadmin.org/download/pgadmin-4-apt/

安装和配置：https://linux.cn/article-11480-1.html

基本命令：

https://www.jianshu.com/p/c4ef1e70f0ff

https://www.runoob.com/postgresql/postgresql-create-database.html

登陆与权限管理：

https://www.cnblogs.com/xuchunlin/p/5621248.html

http://doocr.com/articles/58f883a92ac7dc4b4f0b93fd

https://blog.51cto.com/u_15080030/4283286

https://blog.csdn.net/hjh872505574/article/details/91411530

```bash
# 创建PostgreSQL角色，\PostgreSQL\11\bin
createuser -s -r postgres
sudo su postgres
psql postgres #登入默认数据库
# 登陆数据库简化版
sudo -u postgres psql postgres
# 登陆后修改密码
\password postgres
```

## MySQL

[Windows平台下安装MySQL数据库——最详细教程来啦！ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/296292628#:~:text=Windows 下安装 MySQL 1 1.首先记住自己的压缩包解压在哪个文件目录（一定要记住MyS ... 2 2.然后进入计算机的环境变量,mysql 6 8.登陆旧密码登陆（第3步中的密码）： mysql -u ... 7 9.修改密码)

# Visual Studio Code

[在linux上安装VSCode - 简书 (jianshu.com)](https://www.jianshu.com/p/9387d192f377)

### 项目和解决方案

[visual C++ 项目和解决方案的区别 - roucheng - 博客园 (cnblogs.com)](https://www.cnblogs.com/roucheng/archive/2016/05/30/cppxiangmu.html)

#### 项目

项目是构成某个程序的全部组件的容器，该程序可能是控制台程序、基于窗口的程序或某种别的程序。程序通常由一个或多个包含用户代码的源文件，可能还要加上包含其它辅助数据的文件组成。某个项目的所有文件都存储在相应的项目文件夹中，关于项目的详细信息存储在一个扩展名为.vcproj的xml文件中，该文件同样存储在相应的项目文件夹中。项目文件夹还包括其它文件夹，它们用来存储编译及链接项目时所产生的输出。

#### 解决方案

顾名思义，解决方案的含义是一种将所有程序和其它资源（它们是某个具体的数据处理问题的解决方案）聚集到一起的机制。例如，用于企业经营的分布式订单录入系统可能由若干个不同的程序组成，而各个程序是作为同一个解决方案内的项目开发的，因此，解决方案就是存储与一个或多个项目有关的所有信息的文件夹，这样就有一个或多个项目文件夹是解决方案文件夹的子文件夹。与解决方案中项目有关的信息存储在扩展名为.sln和.suo的两个文件中。当创建某个项目时，如果没有选择在现有的解决方案中添加该项目，那么系统将自动创建一个新的解决方案。

#### 二者联系

当创建项目及解决方案时，可以在同一个解决方案中添加更多的项目。我们可以在现有的解决方案中添加任意种类的项目，但通常只添加与该解决方案内现有项目相关的项目。一般来说，各个项目都应该有自己的解决方案，除非我们有很好的理由不这样做。

### 编程环境与插件

##### 配置IntelliSense

生成`c_cpp_properties.json`文件来配置缺少的信息：`ctrl+shift+P`打开Command Palette,运行`C/Cpp: Edit configurations...`生成c_cpp_properties.json：

```json
{
    "configurations": [
        {
            "name": "Linux",        
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [],
            "compilerPath": "/usr/bin/gcc",  //编译器路径
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "clang-x64"
        }
    ],
    "version": 4
}
```

##### 构建应用程序

生成`tasks.json`文件，根据自己需求修改`command`、`args`或其他字段。：

Ctrl+Shift+P -> Tasks: Configure Tasks… -> Create tasks.json file from templates -> Others.

```json
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build demo1",                                 //任务标签
            "type": "shell",                                             //类型
            "command": "g++",                                    //对应的命令：g++ -g demo1.cpp -o demo
            "args": [
                "-g",
                "demo1.cpp",
                "-o",
                "demo"
            ],
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

##### DEBUG代码

要启用调试，需要生成launcher.json文件:

点击菜单栏DEBUG->Add Configuration ->选择C++ (GDB/LLDB)(Windows下选择C++ Windows) ，这时将会生成launcher.json文件:

必须将`program`属性的值修改为要执行的文件;

然后点击Debug->Start Debugging，既可以开始调试了，点击侧边栏的Debug图标可查看BreakPoint、Call Stack等。

```json
{
   "version": "0.2.0",
   "configurations": [
       
       {
           "name": "(gdb) Launch",	// 配置名称，将会在启动配置的下拉菜单中显示
           "type": "cppdbg", 		// 配置类型，这里只能为cppdbg
           "request": "launch",	// 请求配置类型，可以为launch（启动）或attach（附加）
           "program": "${workspaceRoot}/${fileBasenameNoExtension}.exe",// 将要进行调试的程序的路径
           "args": [],				// 程序调试时传递给程序的命令行参数，一般设为空即可
           "stopAtEntry": false, 	// 设为true时程序将暂停在程序入口处，一般设置为false
           "cwd": "${workspaceRoot}",// 调试程序时的工作目录，一般为${workspaceRoot}即代码所在目录
           "environment": [],
           "externalConsole": true,// 调试时是否显示控制台窗口，一般设置为true显示控制台
           "MIMode": "gdb",
           "miDebuggerPath": "xxx\\gdb.exe",// miDebugger的路径，注意这里要与MinGw的路径对应
           "preLaunchTask": "g++",	// 调试会话开始前执行的任务，一般为编译程序，c++为g++, c为gcc
           "setupCommands": [
               {
                   "description": "Enable pretty-printing for gdb",
                   "text": "-enable-pretty-printing",
                   "ignoreFailures": true
               }
           ]
       }
   ]
}
```

### 实用操作

#### 文档重新编码（UTF-8、GB2312互转）

[文档重新编码（UTF-8、GB2312互转）](https://blog.csdn.net/jianglangyixiao/article/details/122918578)

右下角的菜单栏有一个信息显示当前文件的编码方式。如果打开文档发现很多乱码，那么说明文档编码不对

点击UTF-8, 选择reopen with encoding → 你想切换的编码方式。这个是时候文档就正常了

这个时候文档只是被用新的编码方式打开了。如果你想将转码的文档保存下来，令文档在utf-8下正常显示，点击GB-2312 → Save with encoding, 选择UTF-8

# Cmake

[Add the installation prefix to CMAKE_PREFIX_PATH - ROS Answers: Open Source Q&A Forum](https://answers.ros.org/question/130651/add-the-installation-prefix-to-cmake_prefix_path/)

[CMake--模块的使用和自定义模块 - narjaja - 博客园 (cnblogs.com)](https://www.cnblogs.com/narjaja/p/9533199.html)

[(13条消息) ROS编程中如何配置CMakelists.txt来调用外部的动态链接库(.so文件)_Shawn0102的博客-CSDN博客](https://blog.csdn.net/Shawn_Zhangguang/article/details/53609757)

https://blog.csdn.net/weixin_41534481/article/details/121735964

https://www.thinbug.com/q/20746936

https://blog.csdn.net/weixin_45677333/article/details/121332641

[(28条消息) 使用cmake时 什么时候删掉整个build，什么时候只需要make clean_cmake删除_玛丽莲茼蒿的博客-CSDN博客](https://blog.csdn.net/qq_44886213/article/details/121771200)

[如何为CMake指定新的GCC路径 | 码农家园 (codenong.com)](https://www.codenong.com/17275348/)

make clean：当源文件发生改变时，只需要make clean重新编译就行了

# Bazel

Bazel 是一款类似于 Make、Maven 和 Gradle的开源构建和测试工具。它使用可读的高级构建语言，支持多种变成语言编写的项目，并且能够为多个平台进行构建。Bazel 支持构建包含多个仓库、大量开发人员的大型代码库



# Git

Git是分布式版本控制系统，可以记录文本文件的不同版本内容，便于恢复和管理。由于是分布式，每台主机都可以有一个仓库，不是必须联网才能操作。

[(12条消息) Git入门_SuperAFeiDa的博客-CSDN博客](https://blog.csdn.net/Q1410136042/article/details/80481233)

[(28条消息) Git安装教程（Windows11安装）_win11安装git_Charon's_Pluto的博客-CSDN博客](https://blog.csdn.net/weixin_42425618/article/details/123501071)

#### git bash https 加速

```shell
git config --global http.proxy "http://127.0.0.1:1080"
git config --global https.proxy "https://127.0.0.1:1080"
```

# Docker

容器虚拟化技术

[(12条消息) Docker技术( 容器虚拟化技术 )_时间静止不是简史的博客-CSDN博客_什么是docker虚拟化技术](https://blog.csdn.net/qq_43371556/article/details/102631158)

#### 安装启动与管理

```shell
# Install
sudo apt install docker.io
# 安装完成后可能需要启动
sudo systemctl start docker
```

[目前国内可用Docker镜像源汇总（截至2024年11月）](https://cloud.tencent.com/developer/article/2459822)

### 基本操作

```shell
###############
##### 镜像 ##### 
###############

# 检查docker管理的镜像
sudo docker images 
# 拉取镜像比如拉取ubuntu16.04
sudo docker pull ubuntu:16.04
# 导出镜像 export 对应 import
sudo docker export ${CONTAINERID} > [tar_from_contain].tar
# 或 save 对应 load
sudo docker save ${IMAGEID} > [tar_from_image].tar
# 导入打包好的tar包作为一个新镜像
sudo docker import ./[tar_from_contain.tar ${new_image_name}
sudo docker load < [tar_from_image].tar 
# 删除镜像
sudo docker image rm ${IMAGEID}

###############
##### 容器 ##### 
###############
	
# 查看本机所有容器
sudo docker ps -a 
# 通过镜像的EPOSITORY和TAG创建并运行一个容器，
# --name指定容器名称;
# -v指定从外向容器内映射挂载的文件目录，挂载/dev让容器访问外部真实设备;
# -p指定从外向容器内映射的端口号，包含前端界面、tcp、websocket等网络端口;
# -itd指定外部为docker开启一个前台保护进程;
# 最后指定运行/bin/bash进入容器.
sudo docker run --name ${container_name} --privileged=true -v ${where your developer project}:/myapp -v /dev:/dev -p 8888:8888 -p 9999:9999 -p 8081:8081 -p 8090:8090 -p 8091:8091 -itd ${EPOSITORY}:${TAG} /bin/bash
# 若容器未运行，start启动
sudo docker start ${CONTAINERID}
# 以/bin/bash进入容器交互终端
sudo docker exec -it --privileged=true ${container_name(tianti-controller-test)} /bin/bash
# 把一个正在运行的容器保存为镜像
sudo docker commit ${CONTAINERID} ${IMAGENAME}
# 停止容器
sudo docker stop ${CONTAINERID}
# 删除容器
sudo docker rm ${CONTAINERID}
```

#### 导入导出的选择建议

1. 根据文件大小选择

   **export** 导出的镜像文件体积小于 **save** 保存的镜像

2. 根据是否要对镜像重命名选择

   - **docker import** 可以为镜像指定新名称

   - **docker load** 不能对载入的镜像重命名

3. 根据是否要同时将多个镜像打包到一个文件中选择

   - **docker export** 不支持
   - **docker save** 支持

4. 是否包含镜像历史

   - **export** 导出（**import** 导入）是根据容器拿到的镜像，再导入时会丢失镜像所有的历史记录和元数据信息（即仅保存容器当时的快照状态），所以无法进行回滚操作。
   - 而 **save** 保存（**load** 加载）的镜像，没有丢失镜像的历史，可以回滚到之前的层（**layer**）。

5. 应用场景不同

   - **docker export 的应用场景**：主要用来制作基础镜像，比如我们从一个 **ubuntu** 镜像启动一个容器，然后安装一些软件和进行一些设置后，使用 **docker export** 保存为一个基础镜像。然后，把这个镜像分发给其他人使用，比如作为基础的开发环境。

   - **docker save 的应用场景**：如果我们的应用是使用 **docker-compose.yml** 编排的多个镜像组合，但我们要部署的客户服务器并不能连外网。这时就可以使用 **docker save** 将用到的镜像打个包，然后拷贝到客户服务器上使用 **docker load** 载入。

#### 配置文件

启动镜像后配置docker端口映射

在本机环境中
```shell
vim /var/ib/docker/containers/xxx/hostconfig.json
```

#### Dockerfile

使用dockerfile来构建docker镜像

```shell
# 在Dockerfile所在目录
sudo docker build -t ${image_name} .
# 如果你想每一次build都不基于之前的缓存，在build 命令加上 --no-cache=true 参数
sudo docker build --no-cache=true -t ${image_name} .
```

```dockerfile
# 在Dockerfile中完成换源,比如
FROM ubuntu:latest
MAINTAINER itdream "itdream6@163.com"
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update
```

#### 疑难杂症

#### No such host

尝试在/etc/docker/daemon.json中添加

```json
{
  "registry-mirrors": ["https://hx8dsaly.mirror.aliyuncs.com"],
  "dns":["192.168.153.2","8.8.4.4"]
}
```



# RoboWare

[(12条消息) RoboWare Studio安装教程_嵙杰的博客-CSDN博客_roboware studio](https://blog.csdn.net/lixujie666/article/details/80139112)

# RVIZ

[(13条消息) ROS学习笔记(八)::RVIZ::Interactive Markers: Writing a Simple Interactive Marker Server_西西刘的博客-CSDN博客](https://blog.csdn.net/u011104647/article/details/50424687)

# TeamViewer

```bash
sudo dpkg -i 文件名.deb # 安装
/usr/local/sunlogin/bin/sunloginclient # 启动
sudo dpkg -r sunloginclient # 卸载
```


# MATLAB

[(12条消息) 1、matlab机器人运动学计算_luowei_memory的博客-CSDN博客_机器人运动控制算法](https://blog.csdn.net/qq_30567891/article/details/78645310)

[在MATLAB中编制劳斯列表并解题 - 豆丁网Docin](https://www.docin.com/p-555259899.html)

[(12条消息) Matlab中margin函数使用_jk_101的博客-CSDN博客_margin matlab](https://blog.csdn.net/jk_101/article/details/107362329)

[利用Matlab求稳态误差的两种方法.pdf (book118.com)](https://max.book118.com/html/2017/0725/124254090.shtm)

# Vim

[vim的复制粘贴(包括系统剪贴板) - 星朝 - 博客园 (cnblogs.com)](https://www.cnblogs.com/jpfss/p/9040561.html)

https://blog.csdn.net/cumian9828/article/details/108154071

#### 配置与插件

[vimawesome](https://vimawesome.com/)

[vimrc自动化与状态栏配置](https://blog.csdn.net/l_changyun/article/details/98252459#_36)

[An Intro to Vim for People Who Use Visual Studio Code](https://www.freecodecamp.org/news/vim-for-people-who-use-visual-studio-code/)

## Neovim+Coc.nvim

[Neovim+Coc.nvim配置 目前个人最舒服终端编辑环境(Python&C++)](http://t.zoukankan.com/cniwoq-p-13272746.html)

[如何在coc-settings.json文件中添加语言服务器的包含路径](https://cloud.tencent.com/developer/ask/sof/1073386)

[The Ultimate NeoVim Config for [Colemak](https://colemak.com/) Users](https://github.com/theniceboy/nvim/blob/master/README.md)

# Beyond Compare

官网下载deb安装包：https://www.scootersoftware.com/

```bash
# 安装依赖
sudo apt-get install gdebi-core
# 解包安装
sudo dpkg -i bcompare-4.3.7.25118_amd64.deb 
# 在/usr/lib/bcompare中通过命令破解
sudo sed -i "s/keexjEP3t4Mue23hrnuPtY4TdcsqNiJL-5174TsUdLmJSIXKfG2NGPwBL6vnRPddT7tH29qpkneX63DO9ECSPE9rzY1zhThHERg8lHM9IBFT+rVuiY823aQJuqzxCKIE1bcDqM4wgW01FH6oCBP1G4ub01xmb4BGSUG6ZrjxWHJyNLyIlGvOhoY2HAYzEtzYGwxFZn2JZ66o4RONkXjX0DF9EzsdUef3UAS+JQ+fCYReLawdjEe6tXCv88GKaaPKWxCeaUL9PejICQgRQOLGOZtZQkLgAelrOtehxz5ANOOqCaJgy2mJLQVLM5SJ9Dli909c5ybvEhVmIC0dc9dWH+/N9KmiLVlKMU7RJqnE+WXEEPI1SgglmfmLc1yVH7dqBb9ehOoKG9UE+HAE1YvH1XX2XVGeEqYUY-Tsk7YBTz0WpSpoYyPgx6Iki5KLtQ5G-aKP9eysnkuOAkrvHU8bLbGtZteGwJarev03PhfCioJL4OSqsmQGEvDbHFEbNl1qJtdwEriR+VNZts9vNNLk7UGfeNwIiqpxjk4Mn09nmSd8FhM4ifvcaIbNCRoMPGl6KU12iseSe+w+1kFsLhX+OhQM8WXcWV10cGqBzQE9OqOLUcg9n0krrR3KrohstS9smTwEx9olyLYppvC0p5i7dAx2deWvM1ZxKNs0BvcXGukR+/g" BCompare
# 复制~/.config/bcompare中最初的信息到bcomppare_backup，复制/usr/bin/bcompare到/usr/bin/bcompare.real，添加新的中间启动脚本每次启动前加载bcomppare_backup中的注册信息到bcompare中
sudo chmod a+x /usr/bin/bcompare
```

```sh
# 新的/usr/bin/bcompare中的内容
#!/bin/sh
cp -rf ~/.config/bcompare_back/* ~/.config/bcompare/
/usr/bin/bcompare.real $@
```



# Clash

https://cndaqiang.github.io/2020/07/17/clash/

https://fishros.org.cn/forum/topic/668/vpn-%E5%B0%8F%E9%B1%BC%E7%94%A8%E4%BA%86%E5%A4%9A%E4%BA%94%E5%85%AD%E5%B9%B4%E7%9A%84vpn%E5%88%86%E4%BA%AB-%E6%94%AF%E6%8C%81linux-windows-android-ios/2?lang=zh-CN

根据观察，clash目前有开源的web前端，启动脚本如下（fishros提供的clash源）

```shell
#!/bin/bash
# -*- coding: UFT-8 -*-
cd /home/user/.clash/
export http_proxy=''
export https_proxy=''
mkdir -p $HOME/.config/clash
xdg-open http://127.0.0.1:1234/ >> /dev/null &
sleep 3
echo "==============================================="
echo "终端通过环境变量设置: export http_proxy=http://127.0.0.1:7890 && export https_proxy=http://127.0.0.1:7890"
echo "配置系统默认代理方式: 系统设置->网络->网络代理->手动->HTTP(127.0.0.1 7890)->HTTPS(127.0.0.1 7890)"
echo "管理页面方法：https://fishros.org.cn/forum/topic/668 "
echo "=============================================="
./clash-linux-amd64-v3
```

拉取网站提供代理服务的clash配置

```shell
export CLASH_SERVER="https://muniu.ink/link/xxx"
cd /home/user/.clash/
export http_proxy=''
export https_proxy=''
mkdir -p $HOME/.config/clash
wget $CLASH_SERVER -O $HOME/.config/clash/config.yaml
sed -i 's/127.0.0.1:9090/0.0.0.0:9090/g'  $HOME/.config/clash/config.yaml
sed -i 's/allow-lan: false/allow-lan: true/g'  $HOME/.config/clash/config.yaml
file_url="http://github.fishros.org/https://github.com/Dreamacro/maxmind-geoip/releases/download/20230912/Country.mmdb"
target_dir="$HOME/.config/clash/"
# 检查文件是否存在
if [ ! -e "${target_dir}Country.mmdb" ]; then
    # 如果文件不存在，则使用wget下载文件
    wget -O "${target_dir}Country.mmdb" "$file_url"
    if [ $? -eq 0 ]; then
        echo "文件下载成功。"
    else
        echo "文件下载失败。"
        exit 1
    fi
else
    echo "文件已存在，无需下载。"
fi
```



# SDK

## librealsense2-SDK

### 安装本体

```bash
sudo aptitude update
git clone https://github.com/IntelRealSense/librealsense.git
# 依赖安装
cd ~/librealsense
sudo aptitude install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev 
sudo aptitude install libglfw3-dev
# 原文件目录许可脚本安装
cd ~/librealsense
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/ 
sudo udevadm control --reload-rules && udevadm trigger
# 编译安装librealsense
cd ~/librealsense
mkdir build && cd build
cmake ../
cmake ../ -DBUILD_EXAMPLES=true
sudo make uninstall && make clean && make && sudo make install
# 打开SDK图形化界面
realsense-viewer
```

### 安装ROS包

```bash
mkdir -p ~/realsense_ws/src/
cd ~/realsense_ws/src/
catkin_init_workspace
git clone https://github.com/IntelRealSense/realsense-ros.git
git clone https://github.com/pal-robotics/ddynamic_reconfigure.git
cd ~/realsense_ws/
catkin_make clean
catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
catkin_make install
# 添加ros需要的环境变量
gedit ./.bashrc
source ~/realsense_ws/devel/setup.bash # 添加部分
# 运行launch文件
roslaunch realsense2_camera rs_camera.launch 
```

## Naoqi-SDK

[Installing the Pepper SDK plug-in — QiSDK (aldebaran.com)](https://android.aldebaran.com/sdk/doc/pepper-sdk/ch1_gettingstarted/installation.html)

#### 常见操作

```python
from naoqi import ALProxy
motionProxy=ALProxy("ALMotion",IP,port)
postureProxy=ALProxy("ALRobotPosture",IP,port)

# 用choregraphe调Arm中的六个参数，最后一个取值在０和１之间，１表示握紧手，０表示松开手
import almathpo
EffectorName="RHand"
Arm=[0.0,0.0,0.0,0.0,0.0,1.0]
Arm=[x*almath.TO_RAD for x in Arm]
Speed=0.5
motionProxy.angleInterpolationWithSpeed(EffectorName,Arm,Speed)
# 返回当前的动作。如果现在的动作不在默认的动作列表中时，则返回“Unknown”
postureProxy.getPosture()   
# 查看默认的动作列表中全部的姿势
postureProxy.getPostureList()
# 使机器人进入参数中要求的预定义姿势，可以改变移动的速度，具备智能效果（自动防摔等等）
postureName=""
Speed=0.5   (０到１之间)
postureProxy.goToPosture(postureName,Speed)
# 和上面的方法效果一样，只是不具备智能效果
postureName=""
Speed=0.5
postureProxy.applyPosture(postureName,Speed)
# 终止现在的位置插值
postureProxy.stopMove()
# 返回当前的Posture Family（相当于把某一系列的动作归为一类）
# 查看所有预定义姿势族的向量
postureProxy.getPostureFamilyList()
postureProxy.getPosture()
# gotoPosture()方法执行失败之前的最多尝试次数（默认为３）
maxtrynumber=5
postureProxy.setMaxTryNumber(maxtrynumber)

```



#### 常用类

##### MotionProxy类

**getSummary：快速地查看到所有关节的当前状态以及正在运行的任务**

```c#
string ip = "127.0.0.1";//NAO的IP地址
int port = 9559;        //NAO的端口号
MotionProxy mp = new MotionProxy(ip, port);//定义MotionProxy的一个对象
string summary = motion.getSummary();      //获取全部的关节状态和任务	
Console.Write(summary);
```

**getJointNames：得到机器人身上或关节链上的关节名称**

```C#
string names = "Body";//关节组的名称，这里用Body做示范，即全身关节
List<string> jointnames = motion.getJointNames(names);//获取关节名
foreach (string name in jointnames)
{
    Console.WriteLine(name);//逐一输出
}
```

**setAngles：通过指定关节名称来控制关节**

```C#
string names = "RShoulderRoll";//关节的名称
float angles = -1.3265f;//目标角度（单位：弧度，注意不同关节有不同的角度限制！）
float fractionMaxSpeed = 0.1f;//达到目标角度所需的速度（0~1）
motion.setAngles(names, angles, fractionMaxSpeed);//向关节发送命令
```

**angleInterpolation和angleInterpolationWithSpeed：定时插值，在已经确定了关节要运动的轨迹时，可以用来设定插值**

```C#
//定时插值：在已经确定了要遵循的轨迹时，可以用来设定插值。
单个关节，单个动作
string names = "HeadYaw";       //关节的名称
float angleLists = 1.0f;        //目标弧度
float times = 1.0f;
bool isAbsolute = true;
motion.angleInterpolation(names, angleLists, times, isAbsolute);
//单个关节，单个动作
string names = "HeadYaw";       //关节的名称
float angleLists = 1.0f;        //目标弧度
float maxspeed = 0.5f;          //最大速度
motion.angleInterpolationWithSpeed(names, angleLists, maxspeed);
 
//多个关节，单个动作
string names = "Head";      //关节的名字（'Head'代表了'HeadYaw'和'HeadPitch'）
List<float> angleLists = new List<float> { 0, 0 };  //与关节数量相同的目标弧度
float times = 1.0f;
bool isAbsolute = true;
motion.angleInterpolation(names, angleLists, times, isAbsolute);
//多个关节，单个动作
string names = "Head";      //关节的名字（'Head'代表了'HeadYaw'和'HeadPitch'）
List<float> angleLists = new List<float> { 1, 1 };  //与关节数量相同的目标弧度
float maxspeed = 0.1f;      //最大速度
motion.angleInterpolationWithSpeed(names, angleLists, maxspeed);
 
//单个关节，多个动作
string names = "HeadYaw";   //关节的名字
List<float> angleLists = new List<float> {1.0f, -1.0f, 1.0f, -1.0f, 0.0f};  //目标弧度组
List<float> times = new List<float> {1.0f, 2.0f, 3.0f, 4.0f, 10.0f};        //相对应时间
bool isAbsolute = true;
motion.angleInterpolation(names, angleLists, times, isAbsolute);
 
//多个关节，多个动作
string[] names = { "HeadYaw", "HeadPitch" };    //关节的名字
float[] HeadYaw_angles = {1.0f, -1.0f, 1.0f, -1.0f};
float[] HeadPitch_angles = {-1.0f};
List<float[]> angleLists = new List<float[]> { HeadYaw_angles, HeadPitch_angles };  //目标弧度组
float[] HeadYaw_times = {1.0f, 2.0f, 3.0f, 4.0f};
float[] HeadPitch_times = {5.0f};
List<float[]> times = new List<float[]> { HeadYaw_times, HeadPitch_times };         //相对应时间
bool isAbsolute = true;
motion.angleInterpolation(names, angleLists, times, isAbsolute);
```

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

# Ventoy

U 盘启动盘制作工具

[GitHub - ventoy/Ventoy: A new bootable USB solution.](https://github.com/ventoy/Ventoy)

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

# 分布式系统工具

## Celery

```
Celery is a simple, flexible, and reliable distributed system to process vast amounts of messages, while providing operations with the tools required to maintain such a system. It’s a task queue with focus on real-time processing, while also supporting task scheduling. Celery has a large and diverse community of users and contributors, you should come join us [on IRC] or [our mailing-list].Celery is Open Source and licensed under the [BSD License].
```

https://www.cnblogs.com/piperck/p/5385238.html

https://www.jianshu.com/p/9a883d83c1a3

## RabbitMQ

官网安装：https://www.rabbitmq.com/install-debian.html#apt-packagecloud

安装与配置：https://www.cnblogs.com/chuijingjing/p/10010145.html

https://www.cnblogs.com/breka/p/9951505.html

权限设置：https://blog.csdn.net/w892824196/article/details/107153325

# 输入法

### 百度日语IME

#### 输入规则

**拗音**：一般来讲，输入拗音的时候，只需要把一段假名后面的元音也就是「i」去掉，再拼上后面所对应的复元音「ya」、「yu」、「yo」即可

**拨音**：ん：“nn”——连续输入两个n就是ん了。

**促音**：① 两次输入同一个非元音罗马字，显示的第一个假名会是促音，比如：切符，きっぷ kippu、学校 がっこう gakkou

② 单独输入小っ的时候可以使用直接输入ltu或者xtu

### Ubuntu Google 中文输入法

https://zhuanlan.zhihu.com/p/529892064

因为自带的IBus运行卡顿效率极低，转用支持谷歌拼音和搜狗拼音的Fcitx框架

```shell
# 可以检查一下fcitx框架是否安装
fcitx --version
sudo apt-get install fcitx-bin
sudo apt-get install fcitx-table 
sudo apt-get install fcitx-table-all  # 非必须，包含fcitx-table和fcitx-pinyin、五笔、五笔拼音等等
sudo apt-get install fcitx-googlepinyin  # 安装谷歌拼音
```

# Wireshark 
```shell
# 添加wireshark用户组
sudo groupadd wireshark 
# 将dumpcap更改为wireshark用户组
sudo chgrp wireshark /usr/bin/dumpcap
# 让wireshark用户组有root权限使用dumpcap
sudo chmod 4755 /usr/bin/dumpcap
# 将需要使用的普通用户名加入wireshark用户组
sudo gpasswd -a <username> wireshark

```

# Gitlab

#### 配置外网访问

https://bbs.huaweicloud.com/blogs/295945

https://blog.csdn.net/luck_anan/article/details/116831947?spm=1001.2014.3001.5501

#### 疑难解答

##### Q1. 代理问题：检查git代理配置、检查环境变量代理配置

```shell
# 首先，查一下git当前全局的 http 代理：
git config --global http.proxy
# 如果有代理，就取消
git config --global --unset http.proxy

# 再查 git https 的代理：
git config --global https.proxy
# 同样的，有就取消
git config --global --unset https.proxy

# 首先，查一下env中的代理：
env | grep -i proxy
# 一般是因为安装了科学上网工具配置了环境变量的原因
# http_proxy=http://127.0.0.1:7890
# https_proxy=https://127.0.0.1:7890
# 有就取消
unset http_proxy
unset https_proxy

# 再查
env | grep -i proxy
# 正常情况下是没有代理了
# 再次查询一下，如果还有的再取消
```

# CloudCompare

### 安装

https://blog.csdn.net/IT_forlearn/article/details/123907937

### 使用点云滤波

https://gitcode.csdn.net/65eec48e1a836825ed79ccfc.html?dp_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTI4MTQ0OCwiZXhwIjoxNzE3NjQwNzgzLCJpYXQiOjE3MTcwMzU5ODMsInVzZXJuYW1lIjoiQWlybG8ifQ.fGYXj2-cqdIWdfV0hxi0OSBl7mMR_Ir4MpOAxHy7hx0

### 高级二次开发

https://zhuanlan.zhihu.com/p/515439135
