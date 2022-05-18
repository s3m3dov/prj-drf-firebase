# Pull base image
FROM python:3.10-alpine
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Set work directory
WORKDIR /app
# Entry point
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
# Install dependencies
COPY requirements.txt requirements.txt
RUN pip install -U pip
RUN pip install -r requirements.txt
# Copy project
COPY . /app
