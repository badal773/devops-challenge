### Build stage: compile the Go binary
FROM golang:1.22-alpine AS builder

WORKDIR /app
# Copy Go source code
COPY main.go .
# Build the Go binary
RUN go build -o simpletimeservice main.go

### Runtime stage: minimal image with non-root user
FROM alpine:latest
# Create a non-root user with UID 2002
RUN adduser -D -u 2002 particle41

# Set working directory
WORKDIR /home/particle41

# Copy the compiled Go binary from the builder stage
COPY --from=builder /app/simpletimeservice .
# Switch to non-root user
USER particle41

# Expose the application port
EXPOSE 8080
# Start the service
CMD ["./simpletimeservice"]
