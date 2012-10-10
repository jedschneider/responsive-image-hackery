require 'sinatra'

get "/" do
  files = %w(underscore.js backbone.js responsive.js)
  @javascripts = files.map do |file|
    f = File.new("public/js/"+file)
    [f.path, f.size]
  end
  haml :index
end

__END__

@@ index
!!!5
%html
  %head
    - @javascripts.each do |js|
      %meta(name="#{js[0]}" content="#{js[1]}")
  %title Test
  %script(src="js/jquery.js" type="text/javascript" charset="utf-8")
  %script(src="js/lazyload.js" type="text/javascript" charset="utf-8")
  %script(src="js/load.js" type="text/javascript" charset="utf-8")

  %body
    %img.spinner(src="images/lowres/spinner.gif")
    %img(src="images/lowres/modeset-crest.png")
