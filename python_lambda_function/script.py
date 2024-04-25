from flask import Flask, request, send_from_directory
from werkzeug.utils import secure_filename

app = Flask(__name__)

@app.route('/', methods=['GET'])
def main_page():
    file_name = request.args.get('index', default='index.html', type=str)
    file_name = secure_filename(file_name)  # Ensure the filename is secure
    directory = './'  # Update this path to your files' directory
    try:
        return send_from_directory(directory, file_name)
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.run(port=5000)
