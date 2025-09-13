#!/bin/bash

set -e

# Mostrar variables para debug
echo "SSL_TRUST_STORE_PATH=$SSL_TRUST_STORE_PATH"
echo "SSL_TRUST_STORE_PASS=$SSL_TRUST_STORE_PASS"
echo "JAVA_HOME=$JAVA_HOME"

keytool -importkeystore -srckeystore $SSL_TRUST_STORE_PATH -destkeystore $JAVA_HOME/lib/security/cacerts -deststorepass changeit -srcstorepass $SSL_TRUST_STORE_PASS -noprompt

cd /database-schema

exec mvn exec:java -Dexec.args="--ACTION=LIQUIBASE_STATUS --PROFILE=SCH --SCENARIO=schema" 
