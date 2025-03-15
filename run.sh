#!/bin/bash

# This script is designed for recent MacBooks with Apple Silicon or Intel chips
# It can run the application either natively or using Docker

# Store the script directory
SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR" || exit 1

# Load environment variables from .env file
if [ -f .env ]; then
    echo "Loading environment variables from .env file"
    export $(grep -v '^#' .env | xargs)
else
    echo "Error: .env file not found. Creating default .env file."
    echo "# Configuration for the LLM service" > .env
    echo "LLM_BASE_URL=http://localhost:12434/engines/llama.cpp/v1" >> .env
    echo "LLM_MODEL_NAME=ignaciolopezluna020/llama3.2:1b" >> .env
    export $(grep -v '^#' .env | xargs)
fi

# Function to check for required commands
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed. Please install it first."
        echo "You can install it using Homebrew: brew install $1"
        return 1
    fi
    return 0
}

# Print system info
echo "Running on macOS $(sw_vers -productVersion)"
echo "CPU Architecture: $(uname -m)"

# Check if Docker is available
USE_DOCKER=true
if ! check_command "docker"; then
    USE_DOCKER=false
    echo "Docker not found. Checking for native Go installation..."
    if ! check_command "go"; then
        echo "Neither Docker nor Go is installed. Please install either Docker or Go to run this application."
        exit 1
    fi
    echo "Go version: $(go version)"
fi

echo

# Run the application based on availability
if [ "$USE_DOCKER" = true ]; then
    # Check for docker-compose/docker compose
    if command -v "docker-compose" &> /dev/null || docker compose version &> /dev/null; then
        echo "Starting go-genai web application using Docker Compose..."
        # Check if docker-compose.yml exists in the current directory
        if [ -f "./docker-compose.yml" ]; then
            # Determine which command to use (docker-compose or docker compose)
            if command -v "docker-compose" &> /dev/null; then
                docker-compose up --build
            else
                docker compose up --build
            fi
        else
            echo "Error: docker-compose.yml not found in the current directory"
            echo "Falling back to direct Docker commands..."
        fi
    else
        echo "Starting go-genai web application using Docker..."
        # Navigate to go-genai directory for Docker build
        cd "$SCRIPT_DIR/go-genai" || exit 1
        
        # Build the Docker image
        docker build -t go-genai .
        
        # Run the container
        echo "Running container..."
        docker run -p 8080:8080 --name go-genai-container --rm go-genai
    fi
else
    echo "Starting go-genai web application natively with Go..."
    
    # Navigate to the go-genai directory
    cd "$SCRIPT_DIR/go-genai" || {
        echo "Error: Cannot navigate to go-genai directory"
        exit 1
    }
    
    # Check if it's the first run and need to download dependencies
    if [ ! -f "go.sum" ]; then
        echo "First run - initializing Go module and downloading dependencies..."
        go mod tidy
    fi
    
    # Run the Go application
    go run main.go
fi

echo "Open http://localhost:8080 in your browser"
echo "Press Ctrl+C to stop the server"