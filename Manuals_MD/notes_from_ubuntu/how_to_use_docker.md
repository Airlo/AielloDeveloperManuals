#!/usr/bin/sh

# 安装天体docker
## docker创建：
apt-get install -y docker.io

## 安装完成后可能需要启动下：
systemctl start docker

## 确认docker状态（activity）
systemctl status docker

## 加载镜像
docker load -i ./tianti.tar

## 查看镜像
docker images

## 解压数据卷tar包(tianti2.tar)
tar -xvf tianti2.tar

## docker运行镜像
docker run --name tianti --privileged=true -v /tianti(tianti2的解压目录):/tianti /dev:/dev -p 8888:8888 -p 9999:9999 8080:8081 -itd tianti:v1.0

## 查看容器id
docker ps -a

## docker启动容器
docker start 922de76a86cf

## 进入容器：
docker exec -it --privileged=true tianti /bin/bash

## cd到tianti-developer目录后启动天体
./build/bin/tianti_ui

---------------------------------------------------------------------------------------------------------------------------------
# 以下为常用docker命令，可以参考熟悉：
## 拉镜像
docker pull ubuntu:16.04

## 设置开机就启动docker
systemctl enable docker

## docker创建ubuntu16.04容器
docker run --name tianti -v /tianti:/tianti -p 8888:8888 -itd ubuntu:16.04

## docker启动容器，start后面为容器id
docker start 922de76a86cf0a994da06d128fda09f2bd1b641bade8becf260b78bdf8a019c3

## 进入容器：
docker exec -it tianti /bin/bash
docker exec -it --privileged=True tianti /bin/bash

## 把一个正在运行的容器保存为镜像（内部注册）
docker commit 922de76a86cf tianti3

## 停止容器
docker stop 922de76a86cf
## 删除容器
docker rm 922de76a86cf

## 保存为镜像tar包（外部迁移）
docker save 922de76a86cf > /home/ligengsen/tianti3.tar

## 启动镜像后配置docker
### 端口映射
在本机环境中
```bash
vim /var/ib/docker/containers/xxx/hostconfig.json
```

### DNS服务解析

在本机环境中找到/etc/docker/daemon.json

```json
{
    "dns": ["8.8.8.8", "114.114.114.114"]
}
```



# tianti稳定版容器和镜像食用方法

现在装环境有几种选择
1. 直接安装一个带有tianti所需依赖的系统，走安装Ubuntu流程，需要拷一个iso
2. 运行docker，需要安装docker，拷一个tianti环境的tar包
3. 使用tianti-installer，运行script文件夹下的tianti_install.sh脚本（适用于Ubuntu18.04，20.04待验证）
4. 根据README文档一步一步安装

#### tianti_ubuntu20.04_docker

```shell
# 导入打包好的tar包作为一个新镜像，内部本质是一个tianti系统的所有文件，可以为镜像取名tianti-controller
sudo docker import ./tianti_ubuntu20.04_root_docker.tar ${image_name(tianti-controller)}
# sha256:xxxxxxxxxxxxxxxxxxxxxx

# 检查docker管理的镜像，看到以下tianti-controller，TAG为latest
sudo docker images
# EPOSITORY          TAG       IMAGE ID       CREATED             SIZE
# tianti-controller   latest    e1e9c990753a   About an hour ago   19.2GB
# python              3.10      2c4de85c90b4   4 months ago        911MB
# tianti              v1.0      844c2d128378   14 months ago       7.78GB

# 通过镜像的EPOSITORY和TAG创建并运行一个容器，
# --name指定容器名称，可以取名tianti-controller-test;
# -v指定从外向容器内映射挂载的文件目录，挂载/dev让容器访问外部真实设备;
# -p指定从外向容器内映射的端口号，包含前端界面、tcp、websocket等网络端口;
# -itd指定外部为docker开启一个前台保护进程;
# 最后指定运行/bin/bash进入容器.
sudo docker run --name ${container_name(tianti-controller-test)} --privileged=true -v ${where your developer project}:/tianti/tianti-developer -v /dev:/dev -p 8888:8888 -p 9999:9999 -p 8081:8081 -p 8090:8090 -p 8091:8091 -itd ${EPOSITORY(tianti-controller)}:${TAG(latest)} /bin/bash

# 检查docker容器进程情况，看到对应容器正常运行，记下CONTAINER ID；否则输出Exited则表示容器已经退出
sudo docker ps -a
# CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
# d229f9221dfa tianti-controller:latest "/bin/bash" 45 minutes ago Up 45 minutes 0.0.0.0:8081->8081/tcp, :::8081->8081/tcp, 0.0.0.0:8888->8888/tcp, :::8888->8888/tcp, 0.0.0.0:9999->9999/tcp, :::9999->9999/tcp ... tianti-controller-test

# 若容器未运行，start启动
sudo docker start ${CONTAINER ID}
# d229f9221dfa

# 以/bin/bash进入容器交互终端
sudo docker exec -it --privileged=true ${container_name(tianti-controller-test)} /bin/bash
```

