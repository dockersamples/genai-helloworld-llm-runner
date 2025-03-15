## Environment Variables

The application uses the following environment variables defined in the `.env` file:

- `LLM_BASE_URL`: The base URL of the LLM API
- `LLM_MODEL_NAME`: The model name to use

To change these settings, simply edit the `.env` file in the root directory of the project.# hello-genai

A simple chatbot web application built with Go that connects to a local LLM service (llama.cpp) to provide AI-powered responses.

## Repository Structure

```
hello-genai/
├── README.md
├── run.sh
├── docker-compose.yml
└── go-genai/
    ├── main.go
    ├── go.mod
    ├── go.sum
    ├── Dockerfile
    └── .dockerignore
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hello-genai.git
   cd hello-genai
   ```

2. Run the application using the script:
   ```bash
   chmod +x run.sh
   ./run.sh
   ```

3. Open your browser and visit http://localhost:8080

## Running Options

### Using Docker (Recommended)

The app can be run using Docker in two ways:

1. Using Docker Compose:
   ```bash
   docker-compose up --build
   ```

2. Using Docker directly:
   ```bash
   cd go-genai
   docker build -t go-genai .
   docker run -p 8080:8080 --name go-genai-container --rm go-genai
   ```

### Running Natively

If Docker is not available, you can still run the app directly with Go:

```bash
cd go-genai
go run main.go
```

## Requirements

- macOS (recent version)
- Either:
  - Docker and Docker Compose (preferred)
  - Go 1.21 or later
- Local LLM server running at `http://localhost:12434/engines/llama.cpp/v1/chat/completions`

## LLM Server Configuration

This application expects a local LLM server compatible with the OpenAI API format. The server should be:

1. Running on localhost:12434
2. Supporting the endpoint `/engines/llama.cpp/v1/chat/completions`
3. Accepting requests in the OpenAI chat format (with messages array)
4. Using the model "ignaciolopezluna020/llama3.2:1b"

If you're using a different LLM server configuration, you may need to modify the `LLMEndpoint` constant in `main.go`.

## License

MIT