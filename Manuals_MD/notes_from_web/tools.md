# python

**基本指令**

```shell
python --version  # 查看版本
update-alternatives --list python  # 查看可切换的版本
update-alternatives --config python  # 切换版本
```

## 虚拟环境工具 [Anaconda.org](https://anaconda.org/)

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
# 创建环境
conda create -n ${new_env_name} python=${python_version}
# 复制环境,局限于conda install安装,跳过pip install安装部分
conda create -n ${new_env_name} --clone ${now_env_name}
# 导出环境(无法直接跨不同系统,起码win11到linux不行,需要把多余包删去)
conda env export --name ${env_name} > environment.yaml 
# 导入环境
conda env create -f environment.yaml
# 删除一个环境
conda env remove -n ${one_env_name}
```

```shell
# 查看conda下的包
conda list
# 安装包 或 安装特定版本的包
conda install ${pkg_name}
conda install ${pkg_name}=${pkg_version}
# 卸载包
conda remove ${pkg_name}
# 更新包 或 更新所有包
conda update ${pkg_name}
conda update --all
# 搜索包
conda search ${search_term}
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

把conda环境添加到jupyter notebook

```shell
conda activate ${opt_env_name}
pip install ipykernel
python -m ipykernel install --name ${env_name_optional}
# 查看已添加到jupyter notebook的kernel
jupyter kernelspec list
# 删除指定的kernel
jupyter kernelspec remove ${kernel_name}
```



## PyCharm

[Pycharm虚拟环境的使用:构建独立的开发环境 - 简书 (jianshu.com)](https://www.jianshu.com/p/b4629ee87e80)

[PyCharm配置数据库出现 No data sources are configured to run this SQL and provide advanced code assis... - 简书 (jianshu.com)](https://www.jianshu.com/p/77ce95b2bf0e)

```shell
source .virtualenvs/my_project/bin/activate  # 在Linux使用pycharm架构下的虚拟环境
```



## PIP

```bash
# 使用pip安装完包后，只需再执行一次命令pip install xx，就会显示安装路径
pip install django_celery_beat -i https://pypi.tuna.tsinghua.edu.cn/simple/ # 临时使用清华源
# 使用pip freeze命令可以查看安装了那些包
pip list # 显示python下的包，进入python查看安装路径 import sys  sys.path
```

```python
# module 'pip' has no attribute 'xxx' 
import pip._internal
print(pip._internal.xxx.get_supported())
```

查看 $PATH 变量，然后思考你平时运行的pip 的绝对路径是在哪里，执行 which pip 验证你的想法。

思考 pip install --user 会把包安装到哪里，不加 --user 会把包安装到哪里，思考为什么不加 --user 需要 sudo 权限

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



## pyinstaller

##### pyinstaller打包gardio问题

* 原因1 pyinstaller 没有准确的识别出用于代码中gradio_client与gradio库的依赖项
* 原因2 gradio库中的代码都是pyi文件，而pyinstaller 在打包时默认库中的都是pyc文件，故而需要修改spec文件

```shell
# 生成spec文件
pyi-makespec --collect-data=gradio_client --collect-data=gradio ${python_file_name}.py
# 在spec中添加对gradio的编译 module_collection_mode={ 'gradio': 'py',}
# 修改后，删除掉目录下的build文件夹，执行 
pyinstaller ${python_file_name}.spec
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

## RDBMS

关系型数据库**（RDBMS, Relational Database Management System）**。它们均基于**关系模型**（Relational Model）设计，具备以下核心特征：

1. **表格结构（Table-Based）**  
   数据以**行和列**的二维表格形式存储，每个表代表一个实体（如用户、订单），列定义属性（如姓名、价格），行表示具体记录。

2. **SQL 支持**  
   使用**结构化查询语言（SQL）** 进行数据操作（如 `SELECT`, `INSERT`, `UPDATE`, `DELETE`），支持复杂的关联查询（`JOIN`）和聚合操作。

3. **ACID 事务**  
   支持事务的原子性（Atomicity）、一致性（Consistency）、隔离性（Isolation）、持久性（Durability），确保数据完整性。

4. **预定义模式（Schema）**  
   要求提前定义表结构（字段类型、约束），写入数据时需严格遵循模式。

### SQLite

[(12条消息) SQLiteStudio使用教程_未来无限的博客-CSDN博客_sqlitestudio](https://blog.csdn.net/qq_30725967/article/details/90205186)

[SQL语句之查询（SELECT) - 西江逐月 - 博客园 (cnblogs.com)](https://www.cnblogs.com/fzxey/p/10883824.html#限定查询)

#### 安全性

##### 设置密码

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

### Oracle

[Oracle数据库下载及安装图文操作步骤_oracle_脚本之家 (jb51.net)](https://www.jb51.net/article/32616.htm)

### PostgreSQL

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


```

```postgresql
'''登陆后修改密码'''
\password postgres
CREATE USER airlo000 WITH PASSWORD 'airlo000';
\du
ALTER USER airlo000 WITH SUPERUSER;
\q
```

### MySQL

[Windows平台下安装MySQL数据库——最详细教程来啦！ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/296292628#:~:text=Windows 下安装 MySQL 1 1.首先记住自己的压缩包解压在哪个文件目录（一定要记住MyS ... 2 2.然后进入计算机的环境变量,mysql 6 8.登陆旧密码登陆（第3步中的密码）： mysql -u ... 7 9.修改密码)

#### 常用命令

```shell
# 登录mysql
msyql -u {username} -p -h {hostip}
```



```mysql
# 用户级操作
CREATE USER {username}@{host} IDENTIFIED BY 'password';  # 增加新用户 
# grant {permissions} on {database}.{table} to {username}@{host} identified by {password}
# example: grant select,insert,update,delete on . to user@localhost identified by "password";
GRANT ALL PRIVILEGES ON *.* TO {username}@{host} WITH GRANT OPTION;
FLUSH PRIVILEGES;
SHOW GRANTS FOR {username}@{host};
DROP USER {username}@{host};

# 数据库操作
show databases;  # 显示数据库列表
use {database};  # 切换数据库
SHOW TABLES;  # 显示数据库中的表
create database {database_name};  # 创建数据库
drop database {database_name};

# 数据表操作
describe {table_name};
```



## NoSQL

NoSQL 用于超大规模数据的存储（例如谷歌或 Facebook 每天为他们的用户收集万亿比特的数据）。这些类型的数据存储不需要固定的模式，无需多余操作就可以横向扩展。

NoSQL 在许多方面性能大大优于非关系型数据库的同时，往往也伴随一些特性的缺失。比较常见的是事务功能的缺失。

**数据库事务正确执行的四个基本要素 ACID：**

|      | 名称                  | 描述                                                         |
| :--- | :-------------------- | ------------------------------------------------------------ |
| A    | Atomicity（原子性）   | 一个事务中的所有操作，要么全部完成，要么全部不完成，不会在中间某个环节结束。事务在执行过程中发生错误，会被回滚到事务开始前的状态，就像这个事务从来没有执行过一样。 |
| C    | Consistency（一致性） | 在事务开始之前和事务结束以后，数据库的完整性没有被破坏。     |
| I    | Isolation（隔离性）   | 数据库允许多个并发事务同时对数据进行读写和修改的能力。隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。 |
| D    | Durability（持久性）  | 事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。 |

**关系型数据库（RDBMS）与非关系型数据库（NoSQL）的对比：**

| 特性         | 关系型数据库（如上述四种）       | NoSQL（如MongoDB、Redis）      |
| ------------ | -------------------------------- | ------------------------------ |
| **数据模型** | 表格结构，严格模式               | 灵活模型（文档、键值、图等）   |
| **扩展性**   | 垂直扩展（增强单机性能）         | 水平扩展（多节点分布式）       |
| **事务支持** | 强ACID                           | 部分支持BASE模型（最终一致性） |
| **适用场景** | 复杂查询、事务一致性要求高的场景 | 高吞吐、灵活模式、海量数据场景 |

### redis

Redis 是一个使用 ANSI C 编写的开源、支持网络、基于内存、可选持久性的键值对存储数据库。Redis 是目前最流行的键值对存储数据库之一。

最佳应用场景：适用于数据变化快且数据库大小可遇见（适合内存容量）的应用程序。

例如：股票价格、数据分析、实时数据搜集、实时通讯。

## 数据库连接池

对于一个简单的数据库应用，由于对于数据库的访问不是很频繁。这时可以简单地在需要访问数据库时，就新创建一个连接，用完后就关闭它，这样做也不会带来什么明显的性能上的开销。但是对于一个复杂的数据库应用，情况就完全不同了。频繁的建立、关闭连接，会极大的减低系统的性能，因为对于连接的使用成了系统性能的瓶颈。

**连接复用**：通过建立一个[数据库连接池](https://zhida.zhihu.com/search?content_id=184888462&content_type=Article&match_order=1&q=数据库连接池&zhida_source=entity)以及一套连接使用管理策略，使得一个数据库连接可以得到高效、安全的复用，避免了数据库连接频繁建立、关闭的开销。

对于共享资源，有一个很著名的设计模式：资源池。该模式正是为了解决资源频繁分配、释放所造成的问题的。把该模式应用到数据库连接管理领域，就是建立一个数据库连接池，提供一套高效的连接分配、使用策略，最终目标是实现连接的高效、安全的复用。

**数据库连接池的基本原理是在内部对象池中维护一定数量的数据库连接，并对外暴露数据库连接获取和返回方法**。如：外部使用者可通过getConnection 方法获取连接，使用完毕后再通过releaseConnection 方法将连接返回，注意此时连接并没有关闭，而是由连接池管理器回收，并为下一次使用做好准备。

- 创建数据库连接的成本相对较高，因此我们选择预先创建它们，并在需要访问数据库时使用它们，而不是即时创建它们。
- 数据库是共享资源，因此创建连接池并在所有业务事务中共享它们是比较好的。
- 数据库连接池限制可以发送到数据库的负载量。

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

#### 常用指令

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

**清除此前的提交记录**

```shell
# 原主分支为master
git checkout --orphan main
git add ./
git commit -m "something"
git branch -D master
git branch -m master
git push -f origin master
```

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

#### 跨平台

conda的requirements.txt的导入导出在docker中使用,

不使用conda list -e 来导出requirements.txt
使用环境的导出导入，注意增加—no-builds参数来构建可以在docker中运行的依赖。

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

#### vi操作

:i 插入模式

  跳到文本的最后一行：按“G”,即非开启大写情况下“shift+g”

  跳到最后一行的最后一个字符 ： 先重复1的操作即按“G”，之后按“$”键，即“shift+4”。

  跳到第一行的第一个字符：先按两次“g”，

  跳转到当前行的第一个字符：在当前行按“0”。

  按 ESC 退出 插入模式

  :w 保存但不退出

  :wq 保存并退出

  :q 退出

  :q! 强制退出，不保存

  :e! 放弃所有修改，从上次保存文件开始再编辑命令历史

```shell
vim -c cmd file  # 在打开文件前，先执行指定的命令；
vim -r file  # 恢复上次异常退出的文件；
vim -R file  # 以只读的方式打开文件，但可以强制保存；
vim -M file  # 以只读的方式打开文件，不可以强制保存；
vim -y num file  # 将编辑窗口的大小设为num行；
vim + file  # 从文件的末尾开始；
vim +num file  # 从第num行开始；
```

[vim的复制粘贴(包括系统剪贴板) - 星朝 - 博客园 (cnblogs.com)](https://www.cnblogs.com/jpfss/p/9040561.html)

https://blog.csdn.net/cumian9828/article/details/108154071

#### 配置与插件

[vimawesome](https://vimawesome.com/)

[vimrc自动化与状态栏配置](https://blog.csdn.net/l_changyun/article/details/98252459#_36)

[An Intro to Vim for People Who Use Visual Studio Code](https://www.freecodecamp.org/news/vim-for-people-who-use-visual-studio-code/)

#### 疑难杂症

##### E212：无法打开并写入文件 解决办法

保存文件时用: w ! sudo tee % ，tee 用于读取输入文件，同时保存%表示当前编辑文件

按8，再按i，进入插入模式，输入=， 按esc进入命令模式，就会出现8个=。 
这在插入分割线时非常有用，如30i+<esc>就插入了36个+组成的分割线。

保存的时候可以指定路径：
:write sth/file.cpp
这样把文件保存到相对路径sth/下。你也可以使用绝对路径。

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



# Clonezilla



# Ollama

#### 常用命令

```shell
# 查看当前Ollama的模型
ollama list
# 增量更新当前部署的模型
ollama pull Qwen2-7B
# 删除一个模型文件
ollama rm Qwen2-7B
# 复制一个模型
ollama cp Qwen2-7B Qwen2-newModel
```



```shell
# 安装NVIDIA Container Toolkit
sudo apt install -y nvidia-container-toolkit
# 在docker中使用GPU运行ollama
docker run --gpus all -d -v /opt/ai/ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
# 下载所需模型
docker exec -it ollama ollama run qwen:7b
docker exec -it ollama ollama run llama3
# 安装运行webui
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

[通过安装NVIDIA Container Toolkit在Docker中使用GPU](https://blog.csdn.net/ayiya_Oese/article/details/114397798)

# Cursor

cursor是一个集成了[GPT4](https://zhida.zhihu.com/search?content_id=252236639&content_type=Article&match_order=1&q=GPT4&zhida_source=entity)、[Claude 3.5](https://zhida.zhihu.com/search?content_id=252236639&content_type=Article&match_order=1&q=Claude+3.5&zhida_source=entity)等先进LLM的类[vscode](https://zhida.zhihu.com/search?content_id=252236639&content_type=Article&match_order=1&q=vscode&zhida_source=entity)的编译器，可以理解为在vscode中集成了AI辅助编程助手，从下图中的页面可以看出cursor的布局和vscode基本一致，并且cursor的使用操作也和vscode一致，包括extension下载、python编译器配置、远程服务器连接和settings等，如果你是资深vscode用户，那么恭喜你可以直接无缝衔接cursor。

# 编码器

#### ffmpeg

```shell
ffmpeg -i input.mp3 -f wav output.wav
ffmpeg -i input.wav -f mp2 output.mp3
```

Ubuntu文件资源管理器中没有缩略图的原因

1. 没有安装ffmpeg和ffmpegthumbnailer

```shell
sudo apt install ffmpegthumbnailer
```

2. Nautilus 的缩略图生成功能未启用

```shell
# 打开 Nautilus 文件管理器。
# 点击右上角的菜单图标，选择“首选项”（Preferences）。
# 在“搜索和预览”选项卡下，确保“显示缩略图”设置为“始终”或“文件小于某大小”。（建议设为 “始终” 以确保所有文件生成缩略图。）
nautilus -q  # 重启资源管理器
rm -rf ~/.cache/thumbnails/*  # 可选,清除缩略图缓存
```

3. 部分格式可能需要特定的解码库来生成缩略图

```shell
sudo apt install ubuntu-restricted-extras gstreamer1.0-libav gstreamer1.0-plugins-good  # 安装支持的视频解码库（如 GStreamer 插件）
```



# Mujoco

# Nginx

#### 伪静态

* 页面能正常跳转，可是css、js和相关的图片就是不出来

```nginx
http {
    server {
        location ~ .* {
            proxy_pass  http://demo;
            proxy_set_header  Host $http_host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```

* 网页开发配置伪静态，

  这个技术可以通过spring 的参数路径来实现，同样可以使用nginx 伪静态实现

  优点：

  1. seo 更友好，静态化路径会更好收录
  2. 更安全，不容易被针对地址所攻击

  例子1. 修改nginx.htaccess文件

```nginx
# Check if a file exists, or route it to index.php.
try_files $uri $uri/ /exploit/index.php?$query_string;
if (!-e $request_filename) {
    rewrite  ^(.*)$  /index.php?s=$1  last;
    break;
}
```
  例子2. 将 http://192.168.203.102/article/detail?articleId=123adsas 改为 http://192.168.203.102/article/detail/123adsas.html
```nginx
server {
    listen       80;
    server_name  localhost;
    rewrite_log on;
 
    access_log  /app/log/nginx/host.access.log  main;
    error_log   /app/log/nginx/host.error.log   notice;
   
    location / {
        proxy_pass   http://127.0.0.1:8080;
        rewrite ^(.*)/article/detail/(\w+).html$ $1/article/detail?articleId=$2 last;
    }
  
}
```

#### 反向代理与负载均衡

负载均衡是指定一系列的后端服务,然后通过指定的策略去负载,最后在location 中指定这个负载均衡节点 , 完成反向代理与负载均衡

#### 动静分离

动态资源(jsp、ftl、thymeleaf)与静态资源(js、css、img)分开部署。
其中nginx 对静态资源的访问性能远高出tomcat 等应用服务器,同时nginx 可以提供缓存和gzip等扩展,在高并发情况下还可以再进行集群避免单点故障

#### 防盗链

# Apache

* url强制下载

要注意，强制下载属性是一种浏览器行为，不是 HTML 的标准属性。因此，无法保证所有浏览器都会遵循这些设置，尤其是在移动设备上的浏览器。有些浏览器可能会将下载的行为委托给用户进行选择。

这可以通过在服务器上的相关配置文件（例如 Apache 的 .htaccess 文件）

```xml
<FilesMatch "\.(jpg|jpeg|png|gif)$">
  Header set Content-Disposition attachment
</FilesMatch>
```

* 打开apache路由重写的功能



# EAC

[实体CD无损翻录/抓轨的通用教程（通过Exact Audio Copy）](https://www.bilibili.com/opus/925630344961458181)
