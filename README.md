# Docker HW

Проект для домашнего задания по теме Docker и Bash.

В проекте есть две сущности:

1. Генератор данных на Python.
2. Аналитик данных на Node.js.

Генератор создает CSV-файл `data/data.csv`.
Аналитик читает этот CSV-файл и создает HTML-отчет `data/report.html`.

## Структура проекта

```text
docker_hw/
├── generator/
│   ├── Dockerfile
│   └── generate.py
├── reporter/
│   ├── Dockerfile
│   ├── package.json
│   └── report.js
├── data/
│   └── .gitkeep
├── local_data/
│   └── .gitkeep
├── .dockerignore
├── .gitignore
├── README.md
└── run.sh
```

## Проверка

### 1. Сборка генератора

```bash
./run.sh build_generator
```

### 2. Генерация CSV

```bash
./run.sh run_generator
```

Проверить наличие файла:

```bash
ls data
```

Ожидается:

```text
data.csv
```

### 3. Сборка аналитика

```bash
./run.sh build_reporter
```

### 4. Генерация отчета

```bash
./run.sh run_reporter
```

Проверить наличие файлов:

```bash
ls data
```

Ожидается:

```text
data.csv
report.html
```

### 5. Проверка структуры проекта

```bash
./run.sh structure
```

### 6. Проверка содержимого volume генератора

```bash
./run.sh inside_generator
```

### 7. Проверка содержимого volume аналитика

```bash
./run.sh inside_reporter
```

### 8. Очистка данных

```bash
./run.sh clear_data
```

Проверить:

```bash
ls data
```

### Полная проверка

```bash
./run.sh build_generator
./run.sh run_generator

./run.sh build_reporter
./run.sh run_reporter

ls data
```
