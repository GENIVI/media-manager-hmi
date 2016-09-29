
/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
  * This Source Code Form is subject to the terms of the Mozilla Public
   * License, v. 2.0. If a copy of the MPL was not distributed with this
    * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
import QtQuick 2.0

import "qrc:/imports/utils/"
import "qrc:/imports/components/"
import com.jlr.dbus 1.0                         // DBus Interface

import Automotive.MediaManagerInterface 1.0
import "mediaManager.js" as MM

Item {
    id: app
    height: 1920
    width: 1080

    property string media_manager_instance

    ListModel {
        id: breadcrumb
    }

    MediaManagerInterface {
        id: mm
        onPlayerAttributeChanged: {
            //MM.setCurrentTrack(idx);
            var track = playlist.listModel.get(idx);

            player.songsinfo.albumArt = track.albumArt;
            player.songsinfo.album = track.album;
            player.songsinfo.track = track.displayName;
            player.songsinfo.artist = track.artist;
        }
    }



    Component.onCompleted: {
        //set the root MM.
        MM.setMediaManagerInstance()
        breadcrumb.append({"path":app.media_manager_instance});

        //Create Root listing
        MM.listThings(app.media_manager_instance);
        MM.updateCurrentPlaylist();

        console.log("Setup completed");
    }

    Image {
        anchors.centerIn: parent
        source: "qrc:/images/Hex-Background.jpg"
    }

    Playlist {
        id:playlist
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 200
    }

    Column {
        id: col
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        width: parent.width
        spacing: 60

        Row {
            spacing: 30
            Rectangle {
                height: label.height
                width: 200
                color: Style.orangeViv
            }
        }

        Rectangle {
            id: divider
            width: parent.width
            height: 2
            color: Style.blueViv
        }

        Player {
            id: player
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    Rectangle {
        id: browser
        x: parent.width
        width: parent.width * 0.6
        height: parent.height - 100
        color: "black"
        opacity: 0.8
        state: 'hidden'

        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: browser
                    x: parent.width
                }
            },
            State {
                name: "visible"
                PropertyChanges {
                    target: browser
                    x: parent.width * 0.4
                }
            }
        ]

        transitions: [
            Transition {
                from: "hidden"
                to: "visible"
                NumberAnimation {
                    properties: "x"
                    duration: 250
                }
            },
            Transition {
                from: "visible"
                to: "hidden"
                NumberAnimation {
                    properties: "x"
                    duration: 250
                }
            }
        ]

    }

    //Contents of the Browser
    Item {
        width: browser.width
        height: browser.height
        anchors.top: browser.top
        anchors.left: browser.left
        anchors.right: browser.right
        anchors.bottom: browser.bottom

        //Back Button
        Item{
            height: backButton.height
            width: 200
            Image {
                id: backButton
                source: "images/back.png"
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                text: "BACK"
                color: "white"
                font.pixelSize: 56
                anchors.left: backButton.right
//                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //Remove the last breadcrumb and get the parent.
                    if(breadcrumb.count - 1 > 0){
                        breadcrumb.remove(breadcrumb.count - 1)

                    }else{
                         browser.state = "hidden"
                        return;
                    }

                    var t = breadcrumb.get(breadcrumb.count - 1)
                    MM.listThings(t.path);

                }
            }
        }

        SongsList {
            id: songsList
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 158
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            clip: true
        }
    }

    Image{
        anchors.top: parent.top
        anchors.right: parent.right
        source: "images/library.png"

        Text {
            text: "Library"
            color: "white"
            font.pixelSize: 72
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                if (browser.state == "hidden") {
                    browser.state = "visible"
                } else {
                    browser.state = "hidden"
                }
            }
        }
    }

}
