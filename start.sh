#!/bin/bash
# Start script for Automated Dynamic Analysis Signature Generation

set -e  # Exit on error

echo "=================================================="
echo "Automated Dynamic Analysis Signature Generation"
echo "=================================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed. Please install Docker first."
    exit 1
fi

# Build the Docker image if it doesn't exist
if ! docker image inspect cape-signature-gen &> /dev/null; then
    echo "Building Docker image..."
    docker build -t cape-signature-gen .
fi

# Start the service
echo "Starting Docker Compose services..."
docker-compose up -d

# Wait for services to be ready
sleep 2

echo ""
echo "=================================================="
echo "Services started successfully!"
echo "=================================================="
echo ""
echo "To interact with the container, run:"
echo "  docker-compose exec cape-signature-gen bash"
echo ""
echo "To view logs, run:"
echo "  docker-compose logs -f cape-signature-gen"
echo ""
echo "To stop services, run:"
echo "  docker-compose down"
echo ""
echo "Project files are mounted at /app inside the container"
echo "=================================================="
