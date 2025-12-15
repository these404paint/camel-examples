FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build
COPY . .

# ✅ 只 build 真正 runnable module
RUN mvn -pl resume-api/resume-api-fileset -am -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app

# ✅ 正確 jar 路徑
COPY --from=build /build/resume-api/resume-api-fileset/target/*jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
