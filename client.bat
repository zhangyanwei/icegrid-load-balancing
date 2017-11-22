@ECHO OFF

FOR /L %%G IN (1,1,10) DO java -jar client.jar ^
    "--Ice.Default.Locator=PrinterIceGrid/Locator:tcp -h localhost -p 4063" ^
    "--Ice.Plugin.IceSSL=IceSSL:com.zeroc.IceSSL.PluginFactory" ^
    "--IceSSL.DefaultDir=%~dp0certs" ^
    "--IceSSL.Keystore=client.jks" ^
    "--IceSSL.Truststore=ca.jks" ^
    "--IceSSL.Password=password" ^
    "--IceSSL.Trace.Security=1" ^
    "--Ice.Trace.Locator=1"

PAUSE