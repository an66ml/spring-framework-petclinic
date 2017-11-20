FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/an66ml/spring-framework-petclinic.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/spring-framework-petclinic /app
RUN mvn install

FROM openjdk:8-jre-alpine
ARG artifactid
ARG version
ENV artifact ${artifactid}-${version}.jar
WORKDIR /app
COPY --from=build /app/target/${artifact} /app
EXPOSE 9966
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar ${artifact}"]
