@ECHO OFF

CALL %~dp0env.bat

:start-registry
MKDIR %~dp0data\registry || echo skip create data folder
START "Registry" CMD /S /K ""%ICE_HOME%\bin\icegridregistry.exe" "--Ice.Config=%~dp0icegridregistry.conf" "--IceGrid.Registry.LMDB.Path=%~dp0data\registry" "--IceGrid.Registry.DefaultTemplates=%ICE_HOME%\config\templates.xml""
START /B /W PING -n 5 127.0.0.1>nul
CALL :start-node 1
CALL :start-node 2
START /B /W PING -n 5 127.0.0.1>nul
GOTO :deploy

:start-node
MKDIR %~dp0data\node\%1 && COPY "%~dp0server.jar" "%~dp0data\node\%1\server.jar" || echo skip create data folder for node %1
START "Node %1" CMD /S /K ""%ICE_HOME%\bin\icegridnode.exe" "--Ice.Config=%~dp0icegridnode-%1.conf" "--IceGrid.Node.Data=%~dp0data\node\%1" "--IceGrid.Node.Output=%~dp0data\node\%1""
EXIT /B

:deploy
"%ICE_HOME%\bin\icegridadmin.exe" "--Ice.Config=%~dp0icegridregistry.conf" -u admin -p admin -e "application add %~dp0app-with-template.xml"
CALL :start-node-server 1
CALL :start-node-server 2
GOTO:EOF

:start-node-server
"%ICE_HOME%\bin\icegridadmin.exe" "--Ice.Config=%~dp0icegridregistry.conf" -u admin -p admin -e "server start PrinterServer-%1"
EXIT /B

CMD /K