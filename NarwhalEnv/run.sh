# 方式1: 使用 docker run
docker run -it --rm \
  -v /home/jzchen/Narwhal:/app \
  -p 8003:8000 \
  narwhal-backend:v1 \
  uvicorn main:app --host 0.0.0.0 --port 8000

# 方式2: 如果使用 docker-compose