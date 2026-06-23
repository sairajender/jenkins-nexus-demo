FROM amazoncorretto:17

COPY target/demo-app-1.1.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
