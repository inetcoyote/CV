```mermaid
---
title: BPMN — Процесс анонимного голосования
---
flowchart TD
    A[Пользователь отправляет голос] --> B{Проверка токена - JWT/email}
    B -->|Невалидный| C[Отклонить: 403 Forbidden]
    B -->|Валидный| D{Уже голосовал?}
    D -->|Да| E[Отклонить: Повторное голосование]
    D -->|Нет| F[Заблокировать повторно Redis]
    F --> G[Обновить кэш результатов - Redis]
    G --> H[Отправить событие в очередь - Kafka/RabbitMQ]
    H --> I[Вернуть ответ пользователю: 200 OK]
    I --> J[Пользователь видит подтверждение]

    H --> K[Worker: Получить из очереди]
    K --> L[Записать голос в БД - Vote]
    L --> M[Обновить агрегированные результаты - PollResultCache]
    M --> N[Залогировать в аудит-систему - SIEM/S3]
    N --> O[Опубликовать обновление - WebSocket/SSE]
    O --> P[Фронтенд: Обновить интерфейс]
    P --> Q[Результаты обновлены ≤ 4 сек]

    style A fill:#4CAF50,stroke:#388E3C,color:white
    style C fill:#f44336,stroke:#d32f2f,color:white
    style E fill:#ff9800,stroke:#f57c00,color:white
    style I fill:#2196F3,stroke:#1976D2,color:white
    style Q fill:#4CAF50,stroke:#388E3C,color:white

    classDef green fill:#4CAF50,stroke:#388E3C,color:white;
    classDef red fill:#f44336,stroke:#d32f2f,color:white;
    classDef orange fill:#ff9800,stroke:#f57c00,color:white;
    classDef blue fill:#2196F3,stroke:#1976D2,color:white;

    class C,E red
    class I,O,P blue
    class Q green