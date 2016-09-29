/* Copyright (C) 2016, Jaguar Land Rover. All Rights Reserved.
*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/

import QtQuick 2.0
import "qrc:/imports/utils/"
import "mediaManager.js" as MM

Item {
    id: albumItem
    width: 800
    height: 102

    function unknown(v, alt) {
        return v !== "undefined" ? v : alt
    }

    Row{
        height: jacket.height
        spacing: 20

        Image {
            id: jacket
            source: MM.unknown(albumArt,"qrc:/MediaPlayer/images/cover_album.png")
            width: 100
            height: albumItem.height
        }

        Column {
            Text {
                id: albumName
                color: Style.white
                font.pointSize: 32
                text:  unknown(displayName, "Unknown album")
            }

            Text {
                id: artistName
                color: Style.blueViv
                font.pointSize: 24
                text: unknown(artist, "Unknown artist")
            }
        }   
    }

    Rectangle {
        id: underline
        width: albumItem.width
        height: 3
        color: Style.blueViv
    }


    MouseArea {
        anchors.fill: albumItem
        onClicked: {
            breadcrumb.append({
                                  path: path
                              })
            MM.listThings(path)
        }
    }
}
