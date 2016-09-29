function setMediaManagerInstance(){
    app.media_manager_instance = mm.discoverMediaManagers()[0];
}

function listThings(item_path){
    var mmItemList = mm.listChildren(item_path,0,100,["*"]);
    songsList.model.clear();

    for(var i = 0; i < mmItemList.length; i++){

        var itemDef = {
            "albumArt": String(mmItemList[i].AlbumArtURL),
            "album": String(mmItemList[i].Album),
            "artist": String(mmItemList[i].Artist),
            "displayName": mmItemList[i].DisplayName,
            "path": mmItemList[i].Path,
            "type": mmItemList[i].Type,
            "typeEx": mmItemList[i].TypeEx,
            "duration": mmItemList[i].Duration
        }
        songsList.model.append(itemDef);
    }
}

/*
updateCurrentPlaylist
Gets the current queued playlist and populates the playlistModel

*/
function updateCurrentPlaylist(){
    var currentQueue = mm.getCurrentPlayQueue();

    playlist.listModel.clear();

    for(var track in currentQueue){
        var trackInfo = {
            "albumArt": String(currentQueue[track].AlbumArtURL),
            "artist": String(currentQueue[track].Artist),
            "album": String(currentQueue[track].Album),
            "displayName": currentQueue[track].DisplayName,
            "path": currentQueue[track].Path,
            "type": currentQueue[track].Type,
            "typeEx": currentQueue[track].TypeEx,
            "duration": currentQueue[track].Duration
        }
        playlist.listModel.append(trackInfo);

    }

}

function updatePlayback (){
   if (mm.isPlaying() === true){
       var value = mm.getPositionAttribute()/100000
       var max = mm.getDurationAttribute()/100000
   }
}

function setPlayButtonState(){
    if(Boolean(mm.isPlaying()) === true){
        playButton.active = false
    }else {
        playButton.active = true
    }
}

function unknown(v, alt){
    return v !== "undefined" ? v : alt
}

function setRepeatButton(){
    var repeatStatus = mm.repeat;
    switch(repeatStatus){

//Temporarily disabled 'repeat one' due to no icon
    case "REPEAT":
        mm.repeat = "NO_REPEAT";
//        mm.repeat = "REPEAT_SINGLE";
        break;
//    case "REPEAT_SINGLE":
//        mm.repeat = "NO_REPEAT";
//        break;
    case "NO_REPEAT":
        mm.repeat = "REPEAT";
        break;
    }

}

