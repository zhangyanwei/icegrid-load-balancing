## 准备工作 ##
1. 安装JDK1.8
2. 安装icegrid(MSI版)
3. 安装python，https://www.python.org/ (用于生成证书创建)
    1. 在命令行下通过pip安装 zeroc-icecertutils(https://pypi.python.org/pypi/zeroc-icecertutils)  

           > pip install zeroc-icecertutils

	2. 证书创建顺序 (以创建registry的证书为例，其中"iceca init"仅创建一次，创建其他证书时不要再次创建)      

           > iceca init
           > iceca create registry
           > iceca export --password password --alias registry registry.jks 

## 运行顺序 ##
1. 运行 start.bat, 会依次启动icegridregistry、icegridnode、然后调用icegridadmin发布服务
2. 运行 client.bat，然后查看调用结果

如何使用icegridgui访问启用了ssl的registry？  

    > start.bat gui
