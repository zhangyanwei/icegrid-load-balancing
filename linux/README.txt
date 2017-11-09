该测试在Ubuntu的Docker镜像下进行。

1. 下载docker for windows
2. 命令行进行docker目录，创建docker镜像
   docker build -t icegrid .
3. 创建icegrid的docker容器
   docker run --rm -d -p 4061:4061 -p 5061:5061 -p 5062:5062 -v c:/docker/linux:/var/lib/ice/icegrid icegrid
4. 使用windows的 icegridadmin.exe 以图形化方式打开icegrid管理工具
5. 通过工具发布 app.xml 
6. 运行 client.bat 进行测试

注：在无图形化的linux环境，没有找到合适的 icegridadmin 管理工具，所以使用 windows 下的工具进行管理（没有关系）。