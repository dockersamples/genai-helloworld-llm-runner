#!/bin/bash

# This script is designed for recent MacBooks with Apple Silicon or Intel chips
# It detects the architecture and runs the appropriate commands

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "Error: Go is not installed. Please install Go first."
    echo "You can install it using Homebrew: brew install go"
    exit 1
fi

# Print system info
echo "Running on macOS $(sw_vers -productVersion)"
echo "CPU Architecture: $(uname -m)"
echo "Go version: $(go version)"
echo

# Navigate to the go-genai directory
cd "$(dirname "$0")/go-genai" || {
    echo "Error: Cannot navigate to go-genai directory"
    exit 1
}

# Check if it's the first run and need to download dependencies
if [ ! -f "go.sum" ]; then
    echo "First run - initializing Go module and downloading dependencies..."
    go mod tidy
fi

# Run the Go application
echo "Starting go-genai web application..."
echo "Open http://localhost:8080 in your browser"
echo "Press Ctrl+C to stop the server"
echo

# Run the application
go run main.go
