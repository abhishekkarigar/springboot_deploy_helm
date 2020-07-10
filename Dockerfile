FROM openjdk:8-jre
COPY target/docker-spring-boot.jar /tmp/docker-spring-boot.jar
ENV SERVER_PORT 8085
EXPOSE ${SERVER_PORT}
CMD ["java","-jar","/tmp/docker-spring-boot.jar"]