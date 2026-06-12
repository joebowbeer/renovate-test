# Stage 1: Build stage
FROM node:24.15-trixie-slim AS build

WORKDIR /app
# Create a simple Hello World script
RUN echo 'console.log("Hello, World!");' > hello.js

# Stage 2: Runtime stage using Distroless Node 24 on Debian 13
# Pinned to a stable digest for gcr.io/distroless/nodejs24-debian13:nonroot
FROM gcr.io/distroless/nodejs24-debian13@sha256:10e262383ceb3a2a5f6f5ceaca5ecebe74951eff21868a055589676eec3a8001

# Distroless images already include a 'nonroot' user (UID 65532)
USER nonroot

WORKDIR /app
# Copy the application from the build stage with correct ownership
COPY --from=build --chown=nonroot:nonroot /app/hello.js .

# Distroless nodejs images use 'node' as the entrypoint by default
CMD ["hello.js"]
