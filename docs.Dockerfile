FROM maven:3.8.6-openjdk-8
COPY . .
RUN mvn clean stampo:build
RUN mkdir -p /target/lavagna/help
ENTRYPOINT [ "mvn","stampo:serve" ]