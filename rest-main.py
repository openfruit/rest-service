#!/usr/bin/env python3

from flask import Flask, request, Response
from flask_api import status
import mysql.connector as mariadb
from datetime import datetime
import sys
import json

app = Flask(__name__)
httpHeaders = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "OPTIONS,POST,GET,PUT,DELETE",
}


@app.route("/getAllOffers", methods=["GET"])
def getAllOffers():
    data = fetchAllOffers()
    if data == "error":
        return '{"status":"error"}', status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return (jsonifyOffers(data), httpHeaders)


@app.route("/createOffer", methods=["PUT"])
def createOffer():
    response = writeNewOffer(request.json)
    if response == "error":
        return "{\"status\":\"error\"}", status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return "{\"status\":\"success\"}", status.HTTP_201_CREATED, httpHeaders


def writeNewOffer(data):
    try:
        connection = getDBConnection()
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO openFruit.`user` (firstname, lastname, longitude, latitude) VALUES('"
            + data["firstname"] + "', '" + data["lastname"] + "', " +
            str(data["longitude"]) + ", " + str(data["latitude"]) + ");")
        cursor.execute("SET @user=LAST_INSERT_ID();")
        cursor.execute(
            "INSERT INTO openFruit.offer (weight, amount, product, date_time_of_entry) VALUES("
            + str(data["weight"]) + ", " + str(data["amount"]) + ", '" +
            data["product"] + "', NOW());")
        cursor.execute(
            "INSERT INTO openFruit.user_has_offer (user_iduser, offerings_idofferings) VALUES(@user, LAST_INSERT_ID());"
        )
        connection.commit()
        connection.close()
        return "success"
    except mariadb.Error as error:
        print("Error: {}".format(error))
    except:
        print("Error:", sys.exc_info()[0])
        return "error"


def jsonifyOffers(listOfOffers):
    response = '{"offers":['
    for i in range(0, len(listOfOffers)):
        response += (
            '{"id":' + str(listOfOffers[i][0]) + ', "product":"' +
            listOfOffers[i][1] + '","weight":"' + str(listOfOffers[i][2]) +
            '", "amount":' + str(listOfOffers[i][3]) + ', "dateTimeOfEntry":"'
            + str(listOfOffers[i][4]) + '", "idUser":' + str(
                listOfOffers[i][5]) + ', "firstname":"' + listOfOffers[i][6] +
            '", "lastname":"' + listOfOffers[i][7] + '", "longitude":' + str(
                listOfOffers[i][8]) + ', "latitude":' + str(
                    listOfOffers[i][9]) + "},")
    response = response[:-1] + "]}"
    return response


def fetchAllOffers():
    try:
        connection = getDBConnection()
        cursor = connection.cursor()
        cursor.execute(
            "SELECT idoffer, product, weight, amount, date_time_of_entry, iduser, firstname, lastname, longitude, latitude FROM offer o INNER JOIN user_has_offer uho ON o.idoffer=uho.offerings_idofferings INNER JOIN user u ON uho.user_iduser=u.idUser;"
        )
        data = cursor.fetchall()
        connection.close()
        return data
    except mariadb.Error as error:
        print("Error: {}".format(error))
    except:
        print("Error:", sys.exc_info()[0])
        return "error"


def getDBConnection():
    mariadb_connection = mariadb.connect(
        host="159.69.220.111",
        user="fabian",
        password=
        "6FXxwBwhVnTyFgndeM4bVFY2aQ2YWGChmVyxt6u8tNmX5uE8rWQDTu39jQB8mqjr",
        database="openFruit",
    )
    return mariadb_connection


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, threaded=True)
