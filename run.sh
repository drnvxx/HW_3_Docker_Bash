#!/usr/bin/env bash

set -e

GENERATOR_IMAGE="csv-generator"
REPORTER_IMAGE="csv-reporter"

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_DIR="$ROOT_DIR/data"
LOCAL_DATA_DIR="$ROOT_DIR/local_data"

create_data_dirs() {
  mkdir -p "$DATA_DIR"
  mkdir -p "$LOCAL_DATA_DIR"
}

case "$1" in
  build_generator)
    docker build -t "$GENERATOR_IMAGE" "$ROOT_DIR/generator"
    ;;

  run_generator)
    create_data_dirs
    docker run --rm \
      -v "$DATA_DIR:/data" \
      "$GENERATOR_IMAGE"
    ;;

  create_local_data)
    create_data_dirs
    python "$ROOT_DIR/generator/generate.py" "$LOCAL_DATA_DIR"
    ;;

  build_reporter)
    docker build -t "$REPORTER_IMAGE" "$ROOT_DIR/reporter"
    ;;

  run_reporter)
    create_data_dirs
    docker run --rm \
      -v "$DATA_DIR:/data" \
      "$REPORTER_IMAGE"
    ;;

  structure)
    find "$ROOT_DIR" \
      -path "$ROOT_DIR/.git" -prune -o \
      -path "$ROOT_DIR/data/*.csv" -prune -o \
      -path "$ROOT_DIR/data/*.html" -prune -o \
      -print
    ;;

  clear_data)
    create_data_dirs
    find "$DATA_DIR" -type f \( -name "*.csv" -o -name "*.html" \) -delete
    ;;

  inside_generator)
    create_data_dirs
    docker run --rm \
      -v "$DATA_DIR:/data" \
      "$GENERATOR_IMAGE" \
      sh -c "ls -la /data && echo '---' && find /data -maxdepth 1 -type f -print"
    ;;

  inside_reporter)
    create_data_dirs
    docker run --rm \
      -v "$DATA_DIR:/data" \
      "$REPORTER_IMAGE" \
      sh -c "ls -la /data && echo '---' && find /data -maxdepth 1 -type f -print"
    ;;

  *)
    echo "Использование:"
    echo "  ./run.sh build_generator"
    echo "  ./run.sh run_generator"
    echo "  ./run.sh create_local_data"
    echo "  ./run.sh build_reporter"
    echo "  ./run.sh run_reporter"
    echo "  ./run.sh structure"
    echo "  ./run.sh clear_data"
    echo "  ./run.sh inside_generator"
    echo "  ./run.sh inside_reporter"
    exit 1
    ;;
esac