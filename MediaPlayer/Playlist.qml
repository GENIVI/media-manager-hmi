import QtQuick 2.0
import "mediaManager.js" as MM


//PlaylistModel contains items for the current playlist: ListModel
//PlaylistItem is the visual Model for individual MediaManager Items: Component
//PlaylistView is the view for the whole list: ListView

Item {
    height: 200

    property ListModel listModel: playlistModel

    ListModel {
        id: playlistModel
    }

    Component {
        id: playlistItem
        Rectangle {
            id: track
            width: 300
            height: 300

            Image {
                id:trackCover
//                source: (albumArt !== undefined) ? albumArt : "images/cover_album.png"
                source: MM.unknown(albumArt,"qrc:/MediaPlayer/images/cover_album.png")
                anchors.fill: parent
            }
            Rectangle{
                height: 100

                anchors.left: track.left
                anchors.right: track.right
                anchors.top: track.bottom
                color: "#80000000"

                Text {
                    text: displayName
                    color: "white"
                    font.pixelSize: 30
                    anchors.fill: parent
//                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    ListView {
        height: 300
        id: playlistView
        model: playlistModel
        delegate: playlistItem
        orientation: ListView.Horizontal
        spacing: 20
        anchors.fill: parent

    }
}
