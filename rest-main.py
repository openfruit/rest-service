#!/usr/bin/env python3

from flask import Flask, request, Response
from flask_api import status
import mysql.connector as mariadb
from datetime import datetime
import sys
import json

app = Flask(__name__)


@app.route("/getAllOffers", methods=['GET'])
def getAllOffers():
    data = fetchAllOffers()
    if(data == 'error'):
        return "{\"status\":\"error\"}", status.HTTP_500_INTERNAL_SERVER_ERROR
    return jsonifyOffers(data),  {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'OPTIONS,POST,GET,PUT,DELETE'}


@app.route('/createOffer', methods=['POST'])
def createOffer():
    response = writeNewOffer(request.json)
    if(response == 'error'):
        return response, status.HTTP_500_INTERNAL_SERVER_ERROR
    return status.HTTP_501_NOT_IMPLEMENTED


def writeNewOffer(data):
    return ''


def jsonifyOffers(listOfOffers):
    response = '{\"offers\":['
    for i in range(0, len(listOfOffers)):
        response += '{\"id\":'+str(listOfOffers[i][0])+', \"product\":\"'+listOfOffers[i][1]+'\",\"weight\":\"'+str(
            listOfOffers[i][2])+'\", \"amount\":'+str(listOfOffers[i][3])+', \"dateTimeOfEntry\":\"'+str(listOfOffers[i][4])+'\", \"idUser\":'+str(listOfOffers[i][5])+', \"firstname\":\"'+str(listOfOffers[i][6])+'\", \"lastname\":\"'+str(listOfOffers[i][7])+'\", \"longitude\":'+str(listOfOffers[i][8])+', \"latitude\":'+str(listOfOffers[i][9])+'},'
    response = response[:-1] + ']}'
    return response


def fetchAllOffers():
    try:
        mariadb_connection = mariadb.connect(
            host='159.69.220.111', user='fabian', password='6FXxwBwhVnTyFgndeM4bVFY2aQ2YWGChmVyxt6u8tNmX5uE8rWQDTu39jQB8mqjr', database='openFruit')
        cursor = mariadb_connection.cursor()
        cursor.execute('SELECT idoffer, product, weight, amount, date_time_of_entry, iduser, firstname, lastname, longitude, latitude FROM offer o INNER JOIN user_has_offer uho ON o.idoffer=uho.offerings_idofferings INNER JOIN user u ON uho.user_iduser=u.idUser;')
        data = cursor.fetchall()
        mariadb_connection.close()
        return data
    except mariadb.Error as error:
        print("Error: {}".format(error))
    except:
        print("Error:", sys.exc_info()[0])
        return 'error'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, threaded=True)
