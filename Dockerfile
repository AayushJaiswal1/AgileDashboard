FROM python:3.11

WORKDIR /app

# Optional: Install system dependencies (only if needed)
# RUN apt-get update && apt-get install -y libpq-dev gcc

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

