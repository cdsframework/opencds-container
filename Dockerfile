FROM tomcat:7-jre8-alpine AS build

# Metadata
LABEL organization="HLN Consulting, LLC"
LABEL maintainer="Andrew Slattery <andrew@hln.com>"

# Tomcat Server
EXPOSE 8080

ENV JAVA_OPTS -Dcds.endpoint.test=http://localhost:8080/opencds-decision-support-service-test/evaluate -Dcds.endpoint.production=http://localhost:8080/opencds-decision-support-service/evaluate

# Copy OpenCDS Decision Support Service to Tomcat Webapps directory
COPY opencds-container/opencds-decision-support-service.war /usr/local/tomcat/webapps/
COPY opencds-container/opencds-decision-support-service-test.war /usr/local/tomcat/webapps/

# Copy OpenCDS REST warfile
COPY opencds-rest-service/target/opencds-rest-service.war /usr/local/tomcat/webapps/

# Copy OpenCDS supporting config files
COPY opencds-container/opencds-rckms-supporting-configs.tar /usr/local/tomcat
COPY opencds-container/opencds-rckms-supporting-configs-test.tar /usr/local/tomcat

# Extract archive
RUN tar -xf /usr/local/tomcat/opencds-rckms-supporting-configs.tar -C /root
RUN tar -xf /usr/local/tomcat/opencds-rckms-supporting-configs-test.tar -C /root

# Run Tomcat server
CMD ["catalina.sh", "run"]
