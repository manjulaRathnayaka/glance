# --- Build stage ---
FROM golang:1.23.6-alpine3.21 AS builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o glance .

# --- Runtime stage ---
FROM alpine:3.21

# Use UID and GID above 10000
RUN addgroup -g 10001 appgroup && adduser -u 10001 -G appgroup -S appuser

WORKDIR /app

COPY --from=builder /app/glance .

# Set ownership so non-root user can access
RUN chown -R 10001:10001 /app

USER 10001:10001

EXPOSE 8080
HEALTHCHECK --timeout=10s --start-period=60s --interval=60s \
  CMD wget --spider -q http://localhost:8080/api/healthz

ENTRYPOINT ["/app/glance", "--config", "/app/config/glance.yml"]

