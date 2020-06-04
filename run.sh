# Configure
export PROJECT_TOOT=__REPLACE_ME__
export APPLICATIONINSIGHTS_CONNECTION_STRING=InstrumentationKey=__REPLACE_ME__
export APPLICATIONINSIGHTS_CONFIGURATION_FILE=$PROJECT_TOOT/src/main/Resources/ApplicationInsights.json

# Kill Prev
kill -9 $(ps aux | grep LocalServerForJavaAgent | grep java | awk {'print$2'})
# Run
java -javaagent:$PROJECT_TOOT/target/azure/applicationinsights-agent-3.jar -jar $PROJECT_TOOT/target/hello-azure-java-agent-0.1.0.jar com.golan.azure.java.agent.LocalServerForJavaAgent > /tmp/hello-azure-java-agent.log &
# Show log
tail -f /tmp/hello-azure-java-agent.log

# Test
curl 'http://localhost:28080/try/1'
curl 'http://localhost:28080/try/2'
curl 'http://localhost:28080/try/3'

curl 'http://localhost:28080/try/4'
curl 'http://localhost:28080/try/5'
curl 'http://localhost:28080/try/6'
