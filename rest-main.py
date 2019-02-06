#!/usr/bin/env python3

from flask import Flask, request, Response
from flask_api import status
import mysql.connector as mariadb
from datetime import datetime
import sys

app = Flask(__name__)
httpHeaders = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "OPTIONS,POST,GET,PUT,DELETE",
}


@app.route("/getAllOffers/<deviceID>", methods=["GET"])
def getAllOffers(deviceID):
    data = fetchAllOffers(deviceID)
    if data == "error":
        return '{"status":"error"}', status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return (jsonifyOffers(data), httpHeaders)

@app.route("/getOwnOffers/<deviceID>", methods=["GET"])
def getOwnOffers(deviceID):
    data = fetchOwnOffers(deviceID)
    if data == "error":
        return '{"status":"error"}', status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return (jsonifyOffers(data), httpHeaders)



@app.route("/createOffer", methods=["PUT"])
def createOffer():
    response = writeNewOffer(request.json)
    if response == "error":
        return "{\"status\":\"error\"}", status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return "{\"status\":\"success\"}", status.HTTP_201_CREATED, httpHeaders


@app.route("/deleteOffer/<idToDelete>", methods=["DELETE"])
def deleteOffer(idToDelete):
    response = deleteOfferFromDB(idToDelete)
    if response == "error":
        return "{\"status\":\"error\"}", status.HTTP_500_INTERNAL_SERVER_ERROR, httpHeaders
    return "{\"status\":\"success\"}", status.HTTP_200_OK, httpHeaders


def deleteOfferFromDB(idToDelete):
    try:
        connection = getDBConnection()
        cursor = connection.cursor()
        cursor.execute(
            "SET @user=(SELECT offer_has_user.user_iduser FROM offer_has_user WHERE offer_idoffer={});"
            .format(idToDelete))
        cursor.execute(
            "DELETE FROM offer_has_user WHERE offer_idoffer={};".
            format(idToDelete))
        cursor.execute("DELETE FROM `user` WHERE iduser=@user;")
        cursor.execute(
            "DELETE FROM offer WHERE idoffer={};".format(idToDelete))
        connection.commit()
        connection.close()
        return "success"
    except mariadb.Error as error:
        print("Error: {}".format(error))
    except:
        print("Error:", sys.exc_info()[0])
        return "error"


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
            "INSERT INTO openFruit.offer (unit, amount, product, deviceID, date_time_of_entry) VALUES('"
            + str(data["unit"]) + "', " + str(data["amount"]) + ", '" +
            data["product"] + "', '"+data["deviceID"]+"', NOW());")
        cursor.execute(
            "INSERT INTO openFruit.offer_has_user (user_iduser, offer_idoffer) VALUES(@user, LAST_INSERT_ID());"
        )
        connection.commit()
        connection.close()
        return "success"
    except mariadb.Error as error:
        print("Error: {}".format(error))
        return "error"
    except:
        print("Error:", sys.exc_info()[0])
        return "error"


def jsonifyOffers(listOfOffers):
    response = '{"offers":['
    for i in range(0, len(listOfOffers)):
        response += (
            '{"id":' + str(listOfOffers[i][0]) + ', "product":"' +
            listOfOffers[i][1] + '","unit":"' + str(listOfOffers[i][2]) +
            '", "amount":' + str(listOfOffers[i][3]) + ', "dateTimeOfEntry":"'
            + str(listOfOffers[i][4]) + '", "idUser":' + str(
                listOfOffers[i][5]) + ', "firstname":"' + listOfOffers[i][6] +
            '", "lastname":"' + listOfOffers[i][7] + '", "longitude":' + str(
                listOfOffers[i][8]) + ', "latitude":' + str(
                    listOfOffers[i][9]) + "},")
    if (response != '{"offers":['):
        response = response[:-1]
    response += "]}"
    return response


def fetchAllOffers(deviceID):
    try:
        connection = getDBConnection()
        cursor = connection.cursor()
        cursor.execute(
            "SELECT idoffer, product, unit, amount, date_time_of_entry, iduser, firstname, lastname, longitude, latitude FROM offer o INNER JOIN offer_has_user uho ON o.idoffer=uho.offer_idoffer INNER JOIN user u ON uho.user_iduser=u.idUser WHERE deviceID!='"+deviceID+"';"
        )
        data = cursor.fetchall()
        connection.close()
        return data
    except mariadb.Error as error:
        print("Error: {}".format(error))
    except:
        print("Error:", sys.exc_info()[0])
        return "error"


def fetchOwnOffers(deviceID):
    try:
        connection = getDBConnection()
        cursor = connection.cursor()
        cursor.execute(
            "SELECT idoffer, product, unit, amount, date_time_of_entry, iduser, firstname, lastname, longitude, latitude FROM offer o INNER JOIN offer_has_user uho ON o.idoffer=uho.offer_idoffer INNER JOIN user u ON uho.user_iduser=u.idUser WHERE deviceID='"+deviceID+"';"
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
        password="6FXxwBwhVnTyFgndeM4bVFY2aQ2YWGChmVyxt6u8tNmX5uE8rWQDTu39jQB8mqjr",
        database="openFruit",
    )
    return mariadb_connection


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, threaded=True)
