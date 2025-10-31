```mermaid
sequenceDiagram
    participant User
    participant Frontend
    participant Backend
    participant Database
    
    User->>Frontend: Login Request
    Frontend->>Backend: Validate User
    Backend->>Database: Query User Data
    Database-->>Backend: Return User Info
    Backend-->>Frontend: Validation Result
    Frontend-->>User: Login Response