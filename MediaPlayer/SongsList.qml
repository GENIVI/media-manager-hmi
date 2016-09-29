/* Copyright (C) 2015, Pioneer Corporation. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import "qrc:/imports/utils/";
import "qrc:/imports/components/";

ListView {
    id: listView

//    property var listTop: currentIndex === -1 ? songsModel.get(0) : songsModel.get(currentIndex)
//    property string file: listTop.filepath ? listTop.filepath : "song.mp3"
//    property string image: listTop.albumart ? listTop.albumart : "images/cover_album.png"

    function listControl(cmd) {
        if("PREVIOUS" === cmd){
            listView.decrementCurrentIndex()
        }else if("NEXT" === cmd){
            listView.incrementCurrentIndex()
        }
        listView.currentItem.clicked()
    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        width: songsList.width - 102
        height: 2
        color: Style.blueViv
    }

    function delegateSelector(element){

        if(element.typeEx != undefined){
            switch(element.typeEx){
            case "music":
                return "ListItem.qml";

            case "container.album.musicAlbum":
                return "AlbumItem.qml";

            default:
                return "AbstractItem.qml"
            }
        }else{
            return "AbstractItem.qml"
        }
    }

    width:parent.width
    height: 102*7+spacing*6
    spacing: 5
    snapMode: ListView.SnapToItem
    model: SongsModel {id:songsModel}
    delegate:
        Loader {
            source: delegateSelector(songsModel.get(index));
        }
}
