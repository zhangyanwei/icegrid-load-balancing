@ECHO OFF

FOR /L %%G IN (1,1,10) DO java -jar client.jar "--Ice.Default.Locator=PrinterIceGrid/Locator:tcp -h localhost -p 4061" "--Ice.Trace.Locator=1" "-Message=Index: %%G, Hello !"

CMD /K