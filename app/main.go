package main

import (
	"encoding/json"
	"net/http"
	"time"
)

// handler returns the current UTC timestamp and the visitor's IP in JSON format
func handler(w http.ResponseWriter, r *http.Request) {

	// Set the response header to indicate JSON content
	w.Header().Set("Content-Type", "application/json")

	// Get the visitor's IP address
	ip := r.Header.Get("X-Forwarded-For")
	if ip == "" {
		ip = r.RemoteAddr
	}

	// Create the response map
	resp := map[string]string{
		"timestamp": time.Now().UTC().Format(time.RFC3339),
		"ip":        ip,
	}
	// Encode the response as JSON
	json.NewEncoder(w).Encode(resp)
}

func main() {
	// Register the handler for the root path
	http.HandleFunc("/", handler)

	// Print server start message
	println("SimpleTimeService Server started at 8080")

	// Start the server on port 8080
	http.ListenAndServe(":8080", nil)
}
