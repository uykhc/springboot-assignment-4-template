# 1단계: 빌드 스테이지
FROM gradle:8.7-jdk17-jammy AS build
WORKDIR /home/gradle/project

COPY . .

RUN gradle clean bootJar --no-daemon

# 2단계: 실행용 스테이지 (JRE)
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
