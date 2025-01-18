#!/bin/sh

# 进入用户目录
cd ~/domains/chanfeng.serv00.net/public_html

# 克隆 nezha 代码库
echo "Cloning nezha repository..."
git clone https://github.com/naiba/nezha.git

# 进入到构建目录
echo "Entering dashboard directory..."
cd ~/domains/chanfeng.serv00.net/public_html/nezha/cmd/dashboard

# 构建项目
echo "Building the project..."
go build -ldflags="-s -w --extldflags '-static -fpic' -X github.com/naiba/nezha/service/singleton.Version=0.16.25"

# 创建 nezhapanel 目录并进入
echo "Creating and entering nezhapanel directory..."
mkdir ~/domains/chanfeng.serv00.net/public_html/nezhapanel
cd ~/domains/chanfeng.serv00.net/public_html/nezhapanel

# 复制构建后的 dashboard 文件
echo "Copying dashboard binary..."
cp ~/domains/chanfeng.serv00.net/public_html/nezha/cmd/dashboard/dashboard ~/domains/chanfeng.serv00.net/public_html/nezhapanel/dashboard

# 复制资源文件
echo "Copying resource directory..."
cp -r ~/domains/chanfeng.serv00.net/public_html/nezha/resource ~/domains/chanfeng.serv00.net/public_html/nezhapanel/resource

# 删除 resource.go 文件
echo "Removing resource.go..."
rm ~/domains/chanfeng.serv00.net/public_html/nezhapanel/resource/resource.go

# 创建数据目录
echo "Creating data directory..."
mkdir ~/domains/chanfeng.serv00.net/public_html/nezhapanel/data

# 复制配置文件
echo "Copying config.yaml..."
cp ~/domains/chanfeng.serv00.net/public_html/nezha/script/config.yaml ~/domains/chanfeng.serv00.net/public_html/nezhapanel/data/config.yaml

# 修改配置文件
echo "Modifying config.yaml..."
sed -i '' 's/language: .*/language: zh-CN/' ~/domains/chanfeng.serv00.net/public_html/nezhapanel/data/config.yaml
sed -i '' 's/httpport: .*/httpport: 12140/' ~/domains/chanfeng.serv00.net/public_html/nezhapanel/data/config.yaml
sed -i '' 's/grpcport: .*/grpcport: 12142/' ~/domains/chanfeng.serv00.net/public_html/nezhapanel/data/config.yaml

# 进入 nezhapanel 目录并设置权限
echo "Entering nezhapanel directory and setting permissions..."
cd ~/domains/chanfeng.serv00.net/public_html/nezhapanel
chmod +x ./dashboard

# 后台运行 dashboard
echo "Running dashboard in the background..."
nohup ./dashboard &

echo "Setup and execution completed."
