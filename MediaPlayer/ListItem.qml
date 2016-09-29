
/* Copyright (C) 2016, Pioneer Corporation, Jaguar LandRover. All Rights Reserved.
*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import "qrc:/imports/utils/"
import "mediaManager.js" as MM

Item {
    id: listItem
    width: 800
    height: 102

//    state: (type == 'music')? "TRACK" : "CONTAINER"

    property int itemHeight: (listItem.height - underline.height) / 3
    property int itemWidth: listItem.width

    signal clicked

    function unknown(v, alt) {
        return v ? v : alt
    }

    onClicked: {
        if(type == "music"){
            mm.enqueueUri(path);
            MM.updateCurrentPlaylist();

        }else{
            breadcrumb.append({
                                  path: path
                              })
            MM.listThings(path)
        }
    }

    Row{
        height: jacket.height
        spacing: 20

        Image {
            id: jacket
            source: MM.unknown(albumArt,"qrc:/MediaPlayer/images/cover_album.png")
            width: 100
            height: listItem.height
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.leftMargin: 10
            anchors.rightMargin: 30
        }

        Column {

            Text {
                id: trackName
                color: Style.white
                font.pixelSize: 30
                text: displayName
            }

            Text {
                id: artistName
                color: Style.blueViv
                font.pixelSize: 25
                text: unknown(artist, "Unknown artist")
            }

            Text {
                id: albumName
                color: Style.white
                font.pixelSize: 25
                text:  unknown(album, "Unknown album")
            }
        }
    }
    Rectangle {
        id: underline
        width: itemWidth
        height: 3
        color: Style.blueViv
    }

    SequentialAnimation {
        id: scaleAnimation

        NumberAnimation {
            target: listItem
            property: "scale"
            from: 1
            to: 0.95
            duration: 100
        }

        NumberAnimation {
            target: listItem
            property: "scale"
            from: 0.95
            to: 1
            duration: 100
        }
    }

    MouseArea {
        anchors.fill: listItem
        onClicked: {
            scaleAnimation.start()
            listItem.clicked()
        }
    }
}
