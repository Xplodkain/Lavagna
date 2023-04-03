FROM maven:3.8.6-openjdk-8 AS builder

WORKDIR /app

COPY . .

RUN mvn   com.mycila:license-maven-plugin:format

RUN mvn verify -DskipTests


FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=builder /app/target ./target/

COPY ./entrypoint.sh .  

RUN chmod +rwx entrypoint.sh

ENV DB_DIALECT MYSQL
ENV DB_URL jdbc:mysql://mysql:3306/lavagna?useSSL=false
ENV DB_USER root
ENV DB_PASS 54321
ENV SPRING_PROFILE dev


ENTRYPOINT ["sh", "entrypoint.sh" ]

EXPOSE 8080
