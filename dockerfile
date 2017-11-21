FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/an66ml/spring-framework-petclinic.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/spring-framework-petclinic /app
RUN ./mvnw tomcat7:run-war
