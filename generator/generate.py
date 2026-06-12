import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["PRODUCT_ID", "PRICE", "QUANTITY", "CATEGORY"]

def generate_row():
    return {
        "PRODUCT_ID": random.randint(1000, 9999),
        "PRICE": round(random.uniform(50.0, 5000.0), 2),
        "QUANTITY": random.randint(1, 100),
        "CATEGORY": random.choice(["food", "electronics", "clothes", "books"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)