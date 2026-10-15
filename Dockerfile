# Stage 1: Build stage
FROM node:24.15-trixie-slim AS build

WORKDIR /app
# Create a simple Hello World script
RUN echo 'console.log("Hello, World!");' > hello.js

# Stage 2: Runtime stage using Distroless Node 24 on Debian 13
# Pinned to a stable digest for gcr.io/distroless/nodejs24-debian13:nonroot
FROM gcr.io/distroless/nodejs24-debian13@sha256:9ddd3f7de61d8c62337cdcbeaceb621de5e0c955ccdc70f4c3586db74a8c278f

# Distroless images already include a 'nonroot' user (UID 65532)
USER nonroot

WORKDIR /app
# Copy the application from the build stage with correct ownership
COPY --from=build --chown=nonroot:nonroot /app/hello.js .

# Distroless nodejs images use 'node' as the entrypoint by default
CMD ["hello.js"]
