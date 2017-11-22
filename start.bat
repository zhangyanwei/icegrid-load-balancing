@ECHO OFF

CALL %~dp0env.bat

If "%~1"=="gui" CALL :start-gui
IF "%~1"=="start-registry" CALL :start-registry
IF "%~1"=="start-node" CALL :start-node %~2
IF "%~1"=="deploy" CALL :deploy
IF "%~1"=="start-server" CALL :start-node-server %~2
IF "%~1"=="" CALL :run
GOTO:EOF

:start-gui
START "Registry" CMD /S /K ^java -jar "%ICE_HOME%\bin\icegridgui.jar" ^
    "--Ice.Plugin.IceSSL=IceSSL:com.zeroc.IceSSL.PluginFactory" ^
    "--IceSSL.DefaultDir=%~dp0certs" ^
    "--IceSSL.Keystore=gui.jks" ^
    "--IceSSL.Truststore=ca.jks" ^
    "--IceSSL.Password=password" ^
    "--IceSSL.Trace.Security=1"
EXIT /B %ERRORLEVEL%

:start-registry
DEL /S /Q /F data 2>nul
RD /S /Q data 2>nul
MKDIR %~dp0data\registry || echo skip create data folder
START "Registry" CMD /S /K ^""%ICE_HOME%\bin\icegridregistry.exe" ^
    "--Ice.Config=%~dp0icegridregistry.conf" ^
    "--IceGrid.Registry.LMDB.Path=%~dp0data\registry" ^
    "--IceSSL.DefaultDir=%~dp0certs"^"
EXIT /B %ERRORLEVEL%

:start-node
MKDIR %~dp0data\node\%1\certs >nul
COPY /B "%~dp0server.jar" "%~dp0data\node\%1\server.jar"
COPY /B "%~dp0certs\*" "%~dp0data\node\%1\certs"
START "Node %1" CMD /S /K ^""%ICE_HOME%\bin\icegridnode.exe" ^
    "--Ice.Config=%~dp0icegridnode.conf" ^
    "--IceGrid.Node.Data=%~dp0data\node\%1" ^
    "--IceGrid.Node.Output=%~dp0data\node\%1" ^
    "--IceGrid.Node.Name=node%1" ^
    "--IceGrid.Node.Endpoints=tcp" ^
    "--IceSSL.DefaultDir=%~dp0certs"^"
EXIT /B %ERRORLEVEL%

:deploy
"%ICE_HOME%\bin\icegridadmin.exe" -u admin -p admin -e "application add %~dp0app-with-template.xml" ^
    "--Ice.Config=%~dp0icegridadmin.conf" ^
    "--IceSSL.DefaultDir=%~dp0certs"
EXIT /B %ERRORLEVEL%

:start-node-server
"%ICE_HOME%\bin\icegridadmin.exe" -u admin -p admin -e "server start PrinterServer-%1" ^
    "--Ice.Config=%~dp0icegridadmin.conf" ^
    "--IceSSL.DefaultDir=%~dp0certs"
EXIT /B %ERRORLEVEL%

:run
CALL :start-registry || GOTO :EOF
START /B /W PING -n 5 127.0.0.1>nul
CALL :start-node 1 || GOTO :EOF
CALL :start-node 2 || GOTO :EOF
START /B /W PING -n 5 127.0.0.1>nul
CALL :deploy || GOTO :EOF
CALL :start-node-server 1 || GOTO :EOF
CALL :start-node-server 2 || GOTO :EOF
GOTO :EOF

CMD /K