#Dockerfile
FROM maven:3.9.11-amazoncorretto-21

RUN mkdir -p /opt/tools /opt/ssl /database-schema

COPY liquibase-generator-mongoDB-0.0.1.jar /opt/tools/liquibase-generator-mongoDB-0.0.1.jar

RUN mvn install:install-file -D file=/opt/tools/liquibase-generator-mongoDB-0.0.1.jar -D groupId=com.gs.ftt -D artifactId=liquibase-generator-mongoDB -D version=0.0.1 -D packaging=jar 

COPY documentdb-truststore.jks /opt/ssl/documentdb-truststore.jks

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /database-schema

ENTRYPOINT ["/entrypoint.sh"]
