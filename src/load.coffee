filesizes = []
filenames = []
options = {}
# in an ideal world jQuery is not loaded beforehand, but
# for this example maybe its fine.
$('img').hide()
$('img.spinner').show()
$.each $("meta"), ()->
  filesizes.push parseInt($(@).attr("content"))
  filename = $(@).attr("name").match(/(\w*\.js)$/)[1]
  filenames.push "/js/#{filename}"

options.endTime = null
options.startTime = new Date().getTime()

# uncomment to pretend you have retina
# window.devicePixelRatio = 2
callback = ->
  options.endTime = new Date().getTime()
  # at this point when the callback is called, we'll have
  # access to underscore and backbone
  options.downloadSize = _.reduce filesizes, (memo, fs)-> memo += fs
  app = new ResponsiveView(options)

LazyLoad.js filenames, ->
  # uncommnt if you want fake some loadtime
  # setTimeout(callback, 145)
  callback()
