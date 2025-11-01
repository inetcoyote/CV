```mermaid
flowchart TD
    Start([User Order]) --> Check{Check Stock}
    Check -->|In Stock| Reserve[Reserve Stock]
    Check -->|Out of Stock| OutOfStock[Out of Stock]
    OutOfStock --> Notify[Notify User]
    Notify --> End1([End])
    
    Reserve --> Payment{Payment Processing}
    Payment -->|Success| ConfirmOrder[Confirm Order]
    Payment -->|Fail| ReleaseStock[Release Stock]
    ReleaseStock --> PaymentFailed[Payment Failed]
    PaymentFailed --> End2([End])
    
    ConfirmOrder --> UpdateInventory[Update Inventory]
    UpdateInventory --> SendNotification[Send Notification]
    SendNotification --> Logistics[Arrange Logistics]
    Logistics --> End3([Order Complete])
    
    style Start fill:#e8f5e8
    style End1 fill:#ffebee
    style End2 fill:#ffebee
    style End3 fill:#e8f5e8
    style OutOfStock fill:#ffebee
    style PaymentFailed fill:#ffebee