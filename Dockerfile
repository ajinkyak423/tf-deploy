FROM python:3.14.3-slim

WORKDIR /app

COPY /app/main.py /app/requirements.txt /app/

RUN pip install -r requirements.txt

EXPOSE 8081

CMD ["python", "main.py"]