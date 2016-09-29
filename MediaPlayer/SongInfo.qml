/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import "qrc:/imports/utils/";
import "qrc:/imports/components/";

Row {
    property string artist
    property string album
    property string track
    property string albumArt


    spacing: 30

    function unknown(v, alt) {
        return v ? v : alt
    }

    Image {
        id: albumart
        source: albumArt
        width: 238
        height: 238
    }

    Column {
        spacing: 20

        Row {
            spacing: 20

            Rectangle {
                width: 80
                height: label.height * 0.7
                color: Style.blueViv
            }

            Text {
                id: label
                color: Style.blueLt
                font.pixelSize: 30
                text: "Now Playing"
            }
        }

        Text {
            id: songArtist
            color: "white"
            font.pixelSize: 35
            text: unknown(artist, "Unknown artist")
        }

        Text {
            id: songAlbum
            color: Style.blueViv
            font.pixelSize: 30
            text: unknown(album, "Unknown album")
        }

        Text {
            id:songTitle
            color: "white"
            font.pixelSize: 40
            text: unknown(track, "Unknown title")
        }
    }
}
