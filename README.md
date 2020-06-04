# hello-azure-java-agent-
Play with Azure Monitoring Java Agent

## Intro
This is a super simple SpringBoot web app where I configured an azure java agent 3 as explained here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/java-in-process-agent



## Mac OS
### Azure Monitor Java Agent with SpringBoot
This have a super simple SpringBoot web app where I configured an azure java agent 3 as explained here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/java-in-process-agent

I can see my application in azure portal.
But I have these weird ERRORs in log
Two lines when my web-app starts:
```
2020-06-03 22:32:38.148+03 ERROR c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_ProcessIOPerformanceCounter: Error in file '/proc/23140/io': Can not read
2020-06-03 22:32:38.150+03 ERROR c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_TotalCpuPerformanceCounter: Error in file '/proc/stat': Can not read
```
And every minute I have these lines in log:
```
2020-06-04 11:05:43.354+03 ERROR c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_TotalCpuPerformanceCounter: Error in file '/proc/stat': Error while parsing file: '%s'
2020-06-04 11:05:43.354+03 TRACE c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_TotalCpuPerformanceCounter: Error in file '/proc/stat': Error while parsing file
java.io.FileNotFoundException: /proc/stat (No such file or directory)
	at java.io.FileInputStream.open0(Native Method)
	at java.io.FileInputStream.open(FileInputStream.java:195)
	at java.io.FileInputStream.<init>(FileInputStream.java:138)
	at java.io.FileReader.<init>(FileReader.java:72)
	at com.microsoft.applicationinsights.internal.perfcounter.UnixTotalCpuPerformanceCounter.getLineOfData(UnixTotalCpuPerformanceCounter.java:102)
	at com.microsoft.applicationinsights.internal.perfcounter.UnixTotalCpuPerformanceCounter.report(UnixTotalCpuPerformanceCounter.java:62)
	at com.microsoft.applicationinsights.internal.perfcounter.PerformanceCounterContainer$1.run(PerformanceCounterContainer.java:232)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:308)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301(ScheduledThreadPoolExecutor.java:180)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:294)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
```
The reason is that the proc folder does not exist on Mac OS:
```
root@MAC_MOUSE /Users/ig2258 # ls /proc/
ls: /proc/: No such file or directory
```
