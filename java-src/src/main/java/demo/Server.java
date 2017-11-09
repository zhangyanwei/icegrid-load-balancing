package demo;

public class Server
{
    public static void main(String[] args) throws Exception
    {
        try(com.zeroc.Ice.Communicator communicator = com.zeroc.Ice.Util.initialize(args))
        {
            com.zeroc.Ice.ObjectAdapter adapter = communicator.createObjectAdapter("PrinterAdapter");
            com.zeroc.Ice.Object object = new PrinterImpl();
            adapter.add(object, com.zeroc.Ice.Util.stringToIdentity("Printer"));
            adapter.activate();
            communicator.waitForShutdown();
        }
    }
}