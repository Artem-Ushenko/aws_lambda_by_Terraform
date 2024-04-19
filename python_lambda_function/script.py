import os
import requests
from flask import Flask, request, jsonify
from dotenv import load_dotenv

app = Flask(__name__)

load_dotenv()
telegram_token = os.getenv('TELEGRAM_TOKEN')
telegram_chat_id = os.getenv('TELEGRAM_CHAT_ID')

@app.route('/webhook', methods=['POST'])
def webhook():

    data = request.get_json(force=True) if request.data else {}
    order_id = data.get('id')
    total = data.get('total')
    message = f'New Order: #{order_id} for a total of ${total}'

    url = f'https://api.telegram.org/bot{telegram_token}/sendMessage'
    data = {'chat_id': telegram_chat_id, 'text': message}
    response = requests.post(url, data=data)

    return jsonify({'status': 'success'}), 200

if __name__ == '__main__':
    app.run(port=5000)
