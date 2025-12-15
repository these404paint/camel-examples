FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build

# copy entire repo (needed for parent pom)
COPY . .

# build ONLY resume-api module
RUN mvn -pl resume-api -am -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app

# copy the built jar
COPY --from=build /build/resume-api/target/*jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
