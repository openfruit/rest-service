from flask import Flask, request
from flask_api import status
import mysql.connector as mariadb

app = Flask(__name__)


@app.route("/getAllOffers", methods=['GET'])
def login():

    data = fetchAllOffers()
    if(data == 'error'):
        return "{\"status\":\"error\"}", status.HTTP_500_INTERNAL_SERVER_ERROR
    return data

@app.rout('/createOffer', methods=['POST'])
def createOffer():
    response = writeNewOffer(request.json)
    if(response == 'error'):
        return response, status.HTTP_500_INTERNAL_SERVER_ERROR
    return response

def writeNewOffer():

    return ''

def fetchAllOffers():
    try:
        mariadb_connection = mariadb.connect(host='159.69.220.111', user='fabian', password='zs6p58fZJhS2nxL4BszHbqRkqGy3jvpxvPq5UxXsbRrUzw2k4xnRfuKUBUa6hS9L', database='openfruit')
        cursor = mariadb_connection.cursor()
        result = cursor.execute('SELECT * FROM offer')
        data = result.fetchone()
        mariadb_connection.close()
        return data
    except:
        return 'error'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
