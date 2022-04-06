FROM frolvlad/alpine-java 
LABEL maintainer="Narayan Punekar"
LABEL description="This Dockerfile installs gs-serving-web-content"
COPY ./target/serving-web-content-complete-0.0.2-SNAPSHOT.jar gs-serving-web-content-app.jar  
ENTRYPOINT ["java", "-jar", "gs-serving-web-content-app.jar"] 
