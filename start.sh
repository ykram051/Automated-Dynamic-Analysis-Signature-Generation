#!/usr/bin/env bash
# Start script for Automated Dynamic Analysis Signature Generation

set -euo pipefail

# Always run from the repository root, regardless of caller's current directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=================================================="
echo "Automated Dynamic Analysis Signature Generation"
echo "=================================================="

# Check if Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed. Please install Docker first."
    exit 1
fi

# Determine Docker Compose command (prefer v2 plugin, fallback to v1 binary).
if docker compose version >/dev/null 2>&1; then
    COMPOSE_CMD=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
    COMPOSE_CMD=(docker-compose)
else
    echo "ERROR: Docker Compose is not available. Install Docker Compose v2 or docker-compose."
    exit 1
fi

# Build the Docker image if it doesn't exist
if ! docker image inspect cape-signature-gen >/dev/null 2>&1; then
    echo "Building Docker image..."
    docker build -t cape-signature-gen .
fi

# Start the service
echo "Starting Docker Compose services..."
"${COMPOSE_CMD[@]}" up -d

# Wait for services to be ready
sleep 2

echo ""
echo "=================================================="
echo "Services started successfully!"
echo "=================================================="
echo ""
echo "To interact with the container, run:"
echo "  ${COMPOSE_CMD[*]} exec cape-signature-gen bash"
echo ""
echo "To view logs, run:"
echo "  ${COMPOSE_CMD[*]} logs -f cape-signature-gen"
echo ""
echo "To stop services, run:"
echo "  ${COMPOSE_CMD[*]} down"
echo ""
echo "Project files are mounted at /app inside the container"
echo "=================================================="
