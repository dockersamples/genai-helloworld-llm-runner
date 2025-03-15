## Environment Variables

The application uses the following environment variables defined in the `.env` file:

- `LLM_BASE_URL`: The base URL of the LLM API
- `LLM_MODEL_NAME`: The model name to use

To change these settings, simply edit the `.env` file in the root directory of the project.# hello-genai

A simple chatbot web application built with Go and Python that connects to a local LLM service (llama.cpp) to provide AI-powered responses.

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hello-genai.git
   cd hello-genai
   ```

2. Run the application using the script:
   ```bash
   ./run.sh
   ```

3. Open your browser and visit http://localhost:8080 for the Go application and http://localhost:9090 for the Python application.

## Requirements

- macOS (recent version)
- Either:
  - Docker and Docker Compose (preferred)
  - Go 1.21 or later
- Local LLM server

If you're using a different LLM server configuration, you may need to modify the`.env` file.
