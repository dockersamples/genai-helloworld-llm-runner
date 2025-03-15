package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"
	"time"
)

func main() {
	// Configure server
	port := "8080"
	if envPort := os.Getenv("PORT"); envPort != "" {
		port = envPort
	}

	// Create a new server mux
	mux := http.NewServeMux()

	// Handler for the root path
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" {
			http.NotFound(w, r)
			return
		}

		// Get system information
		goVersion := runtime.Version()
		osInfo := fmt.Sprintf("%s/%s", runtime.GOOS, runtime.GOARCH)

		// Generate HTML response
		html := fmt.Sprintf(`
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello, GenAI!</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #0078D7;
        }
        .container {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .footer {
            margin-top: 40px;
            font-size: 0.8rem;
            color: #666;
        }
        code {
            background-color: #f0f0f0;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace;
        }
    </style>
</head>
<body>
    <h1>Hello, GenAI!</h1>
    <div class="container">
        <p>Welcome to the <strong>go-genai</strong> web application!</p>
        <p>This is a simple Hello World web app built with Go.</p>
        <p>TODO HERE!</p>
    </div>
</body>
</html>
`, time.Now().Format(time.RFC1123), goVersion, osInfo, time.Now().Year())

		// Set content type and write response
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		fmt.Fprint(w, html)
	})

	// Start the server
	serverAddr := ":" + port
	fmt.Printf("Server starting on http://localhost%s\n", serverAddr)
	log.Fatal(http.ListenAndServe(serverAddr, mux))
}
