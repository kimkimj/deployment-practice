# ---- Build stage ----
FROM gradle:8.5-jdk17-alpine as builder

WORKDIR /build

# Cache dependencies first
COPY build.gradle settings.gradle /build/
RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true

# Copy full source
COPY . /build
RUN gradle build -x test --parallel

# ---- Runtime stage ----
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy jar — use your actual jar name here
COPY --from=builder /build/build/libs/deployment-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Optional: run as non-root user
USER nobody

ENTRYPOINT [ \
    "java", \
    "-jar", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dsun.net.inetaddr.ttl=0", \
    "app.jar" \
]
