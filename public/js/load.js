// Generated by CoffeeScript 1.3.3
(function() {
  var callback, filenames, filesizes, options;

  filesizes = [];

  filenames = [];

  options = {};

  $('img').hide();

  $('img.spinner').show();

  $.each($("meta"), function() {
    var filename;
    filesizes.push(parseInt($(this).attr("content")));
    filename = $(this).attr("name").match(/(\w*\.js)$/)[1];
    return filenames.push("/js/" + filename);
  });

  options.endTime = null;

  options.startTime = new Date().getTime();

  callback = function() {
    var app;
    options.endTime = new Date().getTime();
    options.downloadSize = _.reduce(filesizes, function(memo, fs) {
      return memo += fs;
    });
    return app = new ResponsiveView(options);
  };

  LazyLoad.js(filenames, function() {
    return callback();
  });

}).call(this);