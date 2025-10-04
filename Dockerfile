#Multistge builds helps make our image lighter, streamlining the deployment process and making it more efficient

#stage 1, Build stage
FROM python:3.12-slim as Build



WORKDIR /app

#our current directory now becomes that of workdir which is /app, the first . refers to all files of the directory the dockerfile is in which is the hello_flask directory and second one refers to the one we are in in the container whici is /app i/e workdir. so we are copying everything from hello-flask to /app
COPY . .

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

RUN pip install --no-cache-dir -r requirements.txt


#stage 2, Production stage
FROM python:3.12-slim

WORKDIR /app

COPY --from=Build /app /app

EXPOSE 5005

CMD ["python","app.py"]






