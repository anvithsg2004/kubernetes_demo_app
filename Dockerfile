# ---------- Stage 1: build the Spring Boot app ----------
# Maven image with JDK 17
FROM maven:3-eclipse-temurin-17 AS build

# Create and move into /app inside the container
WORKDIR /app

# Copy only pom.xml first and download dependencies (for caching)
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Now copy the source code and build the jar
COPY src ./src
RUN mvn -q -DskipTests clean package


# ---------- Stage 2: run the app ----------
# Smaller runtime image with JRE 17
FROM eclipse-temurin:17-jre-alpine

# Work directory inside the container
WORKDIR /app

# Copy built jar from the first stage and name it app.jar
COPY --from=build /app/target/kubernetes_demo_app-0.0.1-SNAPSHOT.jar app.jar

# The app listens on port 8080
EXPOSE 8080

# Start Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
