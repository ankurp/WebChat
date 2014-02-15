(function() {
  // grab the room from the URL
  var room = location.search && location.search.split('?')[1];

  var webrtc = new SimpleWebRTC({
    // the id/element dom element that will hold "our" video
    localVideoEl: 'localVideo',
    // the id/element dom element that will hold remote videos
    remoteVideosEl: 'remotesVideos',
    // immediately ask for camera access
    autoRequestMedia: true
  });

  webrtc.on('videoAdded', function() {
    $("video#placeholder").hide();
  });

  webrtc.on('videoRemoved', function() {
    if ($("#remotesVideos video").length == 1) {
      $("video#placeholder").show();
    }
  });

  // we have to wait until it's ready
  webrtc.on('readyToCall', function () {
    // you can name it anything
    if (room) webrtc.joinRoom(room);
  });

  // Since we use this twice we put it here
  function setRoom(name) {
    $('form #roomName').prop('disabled', true);
    $('form #roomName').val("Share this link: " + location.href);
  }

  if (room) {
      setRoom(room);
  } else {
      $('form').submit(function () {
          var val = $('#roomName').val().toLowerCase().replace(/\s/g, '').replace(/[^A-Za-z0-9_\-]/g, '');
          webrtc.createRoom(val, function (err, name) {
              var newUrl = location.pathname + '?room=' + name;
              if (!err) {
                  history.replaceState({}, null, newUrl);
                  setRoom(name);
              }
          });
          return false;          
      });
  }
})();
