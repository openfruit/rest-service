from flask import Flask, request
import mysql.connector as mariadb

app = Flask(__name__)


@app.route("/getAllOffers", methods=['GET'])
def login():
    return fetchAllOffers()

def fetchAllOffers():
    try:
        mariadb_connection = mariadb.connect(host='159.69.220.111', user='', password='', database='')
        cursor = mariadb_connection.cursor()
        result = cursor.execute('SELECT * FROM offer')
        data = result.fetchone()
        mariadb_connection.close()
        return data
    except:
        return 'error'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
