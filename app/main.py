from flask import Flask
import random

app = Flask(__name__)

WORDS =["Investments", "Smallcase", "Stocks", "buy-the-dip", "TickerTape"]

@app.route('/api/v1', methods=['GET'])
def get_random_word():
    return random.choice(WORDS)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)