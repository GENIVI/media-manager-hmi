/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0

import com.jlr.dbus 1.0                         // DBus Interface
import Automotive.MediaManagerInterface 1.0     // MediaManager
import "mediaManager.js" as MM

Row {
    property var player
    property var button

    spacing: 100

    Component.onCompleted: {
        DBus.service = "com.jlr.mediaManager"
        DBus.interface = "com.jlr.mediaManager"
        DBus.member = "mediaManager"
    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "previous"
        adjust: -6
        onPressed:{ active = true; }
        onReleased:{ active = false; }
        onClicked: {
            mm.previous();
        }
    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "frewind"
        adjust: -4

        onPressed: {
            rwtimer.start();
            active = true;
        }
        onReleased: {
            rwtimer.stop();
            active = false;
        }

        Timer {
            id: rwtimer
            interval: 1000
            running: false
            repeat: true
            onTriggered:{
                mm.seek(-10000000);
            }
        }
    }

    MediaButton {
        id: playButton
        anchors.verticalCenter: parent.verticalCenter
        icon: "play-pause"
        adjust: -4
        onClicked: {
            mm.playPause();
            MM.setPlayButtonState();

            var playbackStatus;
            if(mm.isPlaying()){
                playbackStatus = "Play";
            }else{
                playbackStatus = "Pause";
            }
        }

        Component.onCompleted: {
            active = mm.isPlaying();
        }

        states:[
            State {
                name:"playing"
                PropertyChanges {
                    target: playButton
                    adjust: -4
                }
            },
            State {
                name:"paused"
                PropertyChanges {
                    target: playButton
                    adjust: 0
                }
            }
        ]
    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "fforward"
        adjust: -6

        onPressed: {
            fftimer.start();
            active = true;
        }
        onReleased: {
            fftimer.stop();
            active = false;
        }

        Timer {
            id: fftimer
            interval: 1000
            running: false
            repeat: true
            onTriggered:{
                mm.seek(10000000);
            }
        }
    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "next"
        adjust: -6
        onPressed:{ active = true; }
        onReleased:{ active = false; }

        onClicked: {
            mm.next();
        }

    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "shuffle"
        adjust: -8
        onClicked: {
            var shuffleStatus = mm.shuffle;
            mm.shuffle = !shuffleStatus;
            active = !shuffleStatus
        }
    }

    MediaButton {
        anchors.verticalCenter: parent.verticalCenter
        icon: "repeat"
        adjust: -2
        onClicked: {
            MM.setRepeatButton()
            active = (mm.repeat == "REPEAT") ? true : false;        }
    }

    Timer {
        id: timer
        interval: 200
        repeat: false
        running: false
        onTriggered: {
            button.active = false
        }
    }
}
