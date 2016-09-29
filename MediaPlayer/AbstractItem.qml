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
    id: abstractItem

    width: 800
    height: 102

    anchors.left: parent.left
    anchors.leftMargin: 20

    Text{
        text:(displayName)
        font.pointSize: 36
        color: "white"
    }
    MouseArea {
        anchors.fill: abstractItem
        onClicked: {
            breadcrumb.append({
                                  path: path
                              })
            MM.listThings(path)
        }
    }
}
