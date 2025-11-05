```plantuml
title Пользователь хочет проголосовать
    participant User as "Пользователь"
    participant Frontend as "Frontend (SPA)"
    participant API as "API Gateway"
    participant Auth as "Auth Service"
    participant Redis as "Redis"
    participant DB as "PostgreSQL"
    'participant Queue as "Message Queue"
    'participant Worker as "Worker"
    'participant WS as "WebSocket Server"
    User->>Frontend: Открывает страницу голосования
    Frontend->>API: GET /polls/active
    API->>DB: SELECT * FROM Poll WHERE is_active = true
    DB-->>API: Данные голосования
    API-->>Frontend: Возвращает варианты
    User->>Frontend: Выбирает вариант и отправляет голос
    Frontend->>API: POST /vote {poll_id, option_ids[], token}
    API->>Auth: Проверка токена
    Auth-->>API: Токен валиден
    API->>Redis: Проверка голоса
    Redis-->>API: Пользователь не голосовал
    API->>DB: Сохранение голоса
    DB-->>API: Голос сохранён
    API->>Redis: Обновление кэша
    Redis-->>API: Кэш обновлён
    API-->>Frontend: Возвращает результат
    Frontend-->>User: Показывает результат

```