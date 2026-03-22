$ErrorActionPreference = "Stop"

Write-Host "=================================================="
Write-Host "Automated Dynamic Analysis Signature Generation"
Write-Host "=================================================="

# Always run from the repository root where this script lives.
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker is not installed or not on PATH. Please install Docker Desktop first."
}

# Ensure Docker daemon is reachable before trying compose/build operations.
docker info *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker daemon is not running. Start Docker Desktop and try again."
}

$composeCmd = $null
try {
    docker compose version | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "docker compose not available"
    }
    $composeCmd = @("docker", "compose")
} catch {
    if (Get-Command docker-compose -ErrorAction SilentlyContinue) {
        $composeCmd = @("docker-compose")
    } else {
        Write-Error "Docker Compose is not available. Install Docker Compose v2 or docker-compose."
    }
}

$imageExists = $true
try {
    docker image inspect cape-signature-gen | Out-Null
} catch {
    $imageExists = $false
}

if (-not $imageExists) {
    Write-Host "Building Docker image..."
    docker build -t cape-signature-gen .
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Docker image build failed."
    }
}

Write-Host "Starting Docker Compose services..."
if ($composeCmd.Count -eq 2) {
    & $composeCmd[0] $composeCmd[1] up -d
} else {
    & $composeCmd[0] up -d
}
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to start Docker Compose services."
}

Start-Sleep -Seconds 2

Write-Host ""
Write-Host "=================================================="
Write-Host "Services started successfully!"
Write-Host "=================================================="
Write-Host ""
if ($composeCmd.Count -eq 2) {
    Write-Host "To interact with the container, run:"
    Write-Host "  docker compose exec cape-signature-gen bash"
    Write-Host ""
    Write-Host "To view logs, run:"
    Write-Host "  docker compose logs -f cape-signature-gen"
    Write-Host ""
    Write-Host "To stop services, run:"
    Write-Host "  docker compose down"
} else {
    Write-Host "To interact with the container, run:"
    Write-Host "  docker-compose exec cape-signature-gen bash"
    Write-Host ""
    Write-Host "To view logs, run:"
    Write-Host "  docker-compose logs -f cape-signature-gen"
    Write-Host ""
    Write-Host "To stop services, run:"
    Write-Host "  docker-compose down"
}
Write-Host ""
Write-Host "Project files are mounted at /app inside the container"
Write-Host "=================================================="
