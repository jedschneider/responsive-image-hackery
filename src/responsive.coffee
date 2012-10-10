
class window.ResponsiveView extends Backbone.View
  # we can configure assets here that the view needs to know about
  # expects that you serve the assets from `images/lowres` on the
  # template and therefore get SEO bump. If you detect big image support,
  # then serve from `images/highres`
  #
  assets :
    logo : "modeset-crest.png"

  initialize: ({@startTime, @endTime, @downloadSize})->
    # more tests and feature detection could be added
    tests = [@onWifi(), @isRetina()]
    console.log "tests", tests
    @highres = _.all(tests, (t)-> t == true)

    @loadAssets()

  # eventually something like this might go in a backbone view extension
  loadAssets: ->
    if @highres == true
      _.each @assets, (asset)->
        image = $("img[src*='#{asset}']")
        $(image).hide()
        newImage = new Image()
        newImage.onload =  ->
          $(image).html(@)
          $(image).show("slow")
        newImage.onError = ->
          console?.log "cant find that image"
        newImage.src = "/images/highres/#{asset}"
    $("img.spinner").hide()


  isRetina : ->
    @retinaEnabled ||= (->
      ratio = parseInt window.devicePixelRatio
      ratio > 1)()

  # reusing the roaming verb to suggest not on wifi
  onWifi: ->
    @deviceSpeed() > 10


  deviceSpeed: ->
    @speedMbps ||= (=>
      duration = (@endTime - @startTime) / 1000
      bitsLoaded = @downloadSize * 8
      speedBps = bitsLoaded / duration
      speedKbps = speedBps / 1024
      speedMbs = speedKbps / 1024
      console.log duration, bitsLoaded, speedBps, speedKbps, speedMbs
      speedMbs
    )()

