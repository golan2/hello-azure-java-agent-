# hello-azure-java-agent-
Play with Azure Monitoring Java Agent

## Intro
This is a super simple SpringBoot web app where I configured an azure java agent 3 as explained here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/java-in-process-agent

## How to use
### Configure
Edit below the two `__REPLACE_ME__` and run it.  
> you will need to go to Azure Portal in order to get the `Instrumentation Key`  
```
export PROJECT_TOOT=__REPLACE_ME__
export APPLICATIONINSIGHTS_CONNECTION_STRING=InstrumentationKey=__REPLACE_ME__
export APPLICATIONINSIGHTS_CONFIGURATION_FILE=$PROJECT_TOOT/src/main/Resources/ApplicationInsights.json
```

### Run
```
# Kill Prev
kill -9 $(ps aux | grep LocalServerForJavaAgent | grep java | awk {'print$2'})
# Run
java -javaagent:$PROJECT_TOOT/target/azure/applicationinsights-agent-3.jar -jar $PROJECT_TOOT/target/hello-azure-java-agent-0.1.0.jar com.golan.azure.java.agent.LocalServerForJavaAgent > /tmp/hello-azure-java-agent.log &
# Show log
tail -f /tmp/hello-azure-java-agent.log
```

## Log too verbose
The java agent is configured to log it all (`TRACE`).  
If you want to change that just edit `ApplicationInsights.json` and rerun.  
```
      "selfDiagnostics": {
        "destination": "console",
        "level": "TRACE"
      }
``` 

### Test
```
curl 'http://localhost:28080/try/1'
curl 'http://localhost:28080/try/2'
curl 'http://localhost:28080/try/3'
```

## Mac OS
### May be a bug...?
I can see my application in azure portal but I have these weird ERROR lines in log.
##### Two lines when my web-app starts:
```
2020-06-03 22:32:38.148+03 ERROR c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_ProcessIOPerformanceCounter: Error in file '/proc/23140/io': Can not read
2020-06-03 22:32:38.150+03 ERROR c.m.a.i.p.AbstractUnixPerformanceCounter - Performance Counter JSDK_TotalCpuPerformanceCounter: Error in file '/proc/stat': Can not read
```
##### And every minute I have these lines in log:
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
The reason (IMO) is that the `proc` folder does not exist on Mac OS.
```
root@MAC_MOUSE /Users/ig2258 # ls /proc/
ls: /proc/: No such file or directory
```
