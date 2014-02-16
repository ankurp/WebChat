(->
  $('body').chardinJs('start')
  if window.webkitRTCPeerConnection
    room = location.pathname.replace(/^\//, "")
    if room
      webrtc = new SimpleWebRTC(
        localVideoEl: "localVideo"
        remoteVideosEl: "remotesVideos"
        autoRequestMedia: true
      )
      webrtc.on "videoAdded", ->
        $("video#placeholder").hide()
        return

      webrtc.on "videoRemoved", ->
        $("video#placeholder").show()  if $("#remotesVideos video").length is 1
        return

      webrtc.on "readyToCall", ->
        webrtc.joinRoom room  if room
        return

    $("form").submit ->
      val = $("#roomName").val().toLowerCase().replace(/\s/g, "").replace(/[^A-Za-z0-9_\-]/g, "")
      newUrl = location.pathname.replace(/\/$/, "") + "/" + val
      window.location = newUrl
      false
  # end if window.webkitRTCPeerConnection
  else
    alert "Currently only Chrome browser is supported.\n\nPlease open in Google Chrome to quickly video chat with friends without installing any plugins and without logging in or creating any accounts."

  return
)()