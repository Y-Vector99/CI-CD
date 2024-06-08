FROM maven:3.9.3 AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
COPY . /app
RUN mvn clean package

FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN apt-get update && apt-get install -y maven  # Installe Maven
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
