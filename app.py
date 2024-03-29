from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    return f"The current time is {current_time}."

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
