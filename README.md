Responsive Image Lazy Load
=========================

Using assets you need to load anyway to establish a bit rate and use
that information to load higher res images when you can.

Basic Problem
============

We don't really know much about a client until they start loading
assets. Then we can use css selectors, window attributes and transfer
rates to establish information about the client's situation and device.

One current practice to establish the transfer rate is to send a known
file at ~50k up to the client and measure speed
https://github.com/teleject/hisrc , this is a solution
that plays on this concept, but instead of uploading a file that is not
used, it uploads javascript assets that will be used to run on the page
anyway.

How it works
===========

The server has a list of javascripts that will be loaded via an async
request. The template generates a list of meta tags that have pointers
to the javascripts and their content size.

The template is served with a basic script that seeks the meta tags and
creates a list of files to load, instantiates a time object to record
the speed of the async request and then the LazyLoad library handles
loading the server side javascripts to the current DOM.

A callback creates the Backbone.View and passes to the view the data
needed to establish the speed of the connection. The callback has access
to any of the javasctipts lazyloaded. in this case i use underscore to
sum the size of the js files loaded.

An assets object within the view configures the retina assets that would
be reloaded given that the view passes all the tests required to load
the higher res images.

The view is ostensibly extendable to include other feature tests that
would be able to detect the load of images. The only condition is that
the test returns true if given that test the higher res images should be
loaded. The assets are configured in two subdirectories of the images
directory. Presumably this could be configured.
