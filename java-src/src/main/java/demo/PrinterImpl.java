package demo;

import com.zeroc.Ice.Current;

public class PrinterImpl implements demo.Printer {

	@Override
	public void print(String message, Current current) {
		System.out.println(message);
	}
	
}