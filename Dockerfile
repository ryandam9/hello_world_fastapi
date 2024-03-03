# Stage 1: Building the Python environment and installing dependencies
FROM python:3.10 AS builder

ENV WORKING_DIR /code

WORKDIR ${WORKING_DIR}

COPY ./requirements.txt /requirements.txt

RUN pip install --no-cache-dir --upgrade -r /requirements.txt

# Stage 2: Final lightweight image
FROM python:3.10-slim

LABEL org.opencontainers.image.authors="ryandam" \
    org.opencontainers.image.description="FastAPI in a container"

ENV WORKING_DIR /code

WORKDIR ${WORKING_DIR}

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY ./app /code/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
