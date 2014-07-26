# encoding: utf-8

require 'sinatra/base'
require 'haml'
require 'browser'

module TheApp
  class OldBrowser < Sinatra::Base
    set :root,          ::File.dirname(__FILE__)
    set :public_folder, ::File.join(root, 'public')
    set :haml,          { format: :html5, ugly: true }

    enable :inline_templates

    before do
      @browzer = Browser.new(ua: request.user_agent)
    end

    get '/?' do
      content_type :html

      @title = 'Out-of-Date Browser Detected'

      haml :index
    end

    run!({ port: 3001 }) if app_file == $0
  end
end

__END__

@@ layout
!!!
%html.no-js{lang: "en"}
  %head
    %meta{charset: "utf-8"}/
    %meta{content: "IE=edge,chrome=1", "http-equiv" => "X-UA-Compatible"}/
    %title= @title
    %meta{content: "Browser Updating Information", name: "description"}/
    %meta{content: "tCg Sys", name: "author"}/
    %meta{content: "width=device-width, initial-scale=1.0", name: "viewport"}/
    %link{rel: "stylesheet", href: "http://yui.yahooapis.com/pure/0.5.0/pure-min.css", type: "text/css"}/
    %link{rel: "stylesheet", href: "http://yui.yahooapis.com/pure/0.5.0/grids-responsive-min.css"}/
    /[if lte IE 8]
      %link{rel: "stylesheet", href: "http://yui.yahooapis.com/pure/0.5.0/grids-responsive-old-ie-min.css"}/
    %link{href: url("css/browser.css"), rel: "stylesheet", type: "text/css"}/
    %script{src: url("js/lib/modernizr-2.7.1.min.js")}
  %body

    = yield

    %footer.pure-g
      #footer.pure-u-1-1
        %span{style: "color: red;"} t
        %span{style: "color: gold;"}> C
        %span{style: "color: blue;"}>< g&nbsp;
        = "&copy;#{Time.now.year}"
        %br/
        %br/

    / Piwik
    :javascript
      var _paq = _paq || [];
      _paq.push(['trackPageView']);
      _paq.push(['enableLinkTracking']);
      (function() {
        var u=window.location.scheme + "://analytiks.tcgsys.com/";
        _paq.push(['setTrackerUrl', u+'piwik.php']);
        _paq.push(['setSiteId', 9999999999999]);
        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
        g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
      })();
    %noscript
      %p
        %img{alt: "", src: "http://analytiks.tcgsys.com/piwik.php?idsite=99999999999", style: "border:0"}/

@@ index
#heading
  .pure-u-1-1
    %h1 You Should Update Your Internet Browser NOW!
    %h3
      The Internet browser you are using is 
      %span.old
        out-of-date 
      and may not display websites properly. It is also less secure.
    %hr/
#main
  .box.pure-u-1-2
    - if @browzer.chrome?
      %a{href: 'https://www.google.com/chrome/browser'}
        .browser-logo#chrome
      %p "You are currently using Google's Chrome browser, version #{@browzer.version}. This is a very good browser, but may not be the latest version."
      %p
        To update it to the latest version
        %a{href: 'https://www.google.com/chrome/browser/'} click here
        for instructions.
    - if @browzer.firefox?
      %a{href: 'http://www.mozilla.org'}
        .browser-logo#firefox
      %p "You are currently using Mozila's Firefox browser, version #{@browzer.version}. It is a nice and secure browser, when kept updated."
      %p
        To make sure you have the latest version, just
        %a{href: 'http://www.mozilla.org'} click here.
    - if @browzer.ie?
      %a{href: 'http://ie.microsoft.com'}
        .browser-logo#ie
      %p "You are currently using Microsoft's Internet Explorer (IE) browser, version #{@browzer.version}. This browser has a long history of NOT behaving 'properly', being the least secure, and the LAST to add, what most would consider, standard features."
      %p
        If you really must contniue using IE (ugh), then
        %a{href: 'http://ie.microsoft.com'} click here
        to find out how to update to the latest version.
    - if @browzer.safari?
      %a{href: 'http://apple.com/safari'}
        .browser-logo#safari
      %p
        "You are currently using Apple's Safari browser, version #{@browzer.version}, a good choice"
        %b when kept up-to-date.
      %p
        To make sure you are using the latest version please visit
        %a{href: 'http://apple.com/safari'} Apple's Safari website.
#alternates.pure-g
  .pure-u-1-1#or Or try something different...
  .pure-u-md-1-5
  - unless @browzer.chrome?
    .box.pure-u-1-1.pure-u-md-1-5
      %a.box{href:'#void'}
        .browser-logo#chrome
        %h5 Google Chrome
        %p This fast and modern web browser has become one of the most popular IE alternatives.
        %a.pure-button.button-secondary{href:'#void'} Learn More
  - unless @browzer.firefox?
    .box.pure-u-1-1.pure-u-md-1-5
      %a.box{href:'#void'}
        .browser-logo#firefox
        %h5 Mozilla Firefox
        %p A popular, up-to-date, and secure alternative Internet browser application.
        %a.pure-button.button-secondary{href:'#void'} Learn More
  - unless @browzer.safari?
    .box.pure-u-1-1.pure-u-md-1-5
      %a.box{href:'#void'}
        .browser-logo#safari
        %h5 Apple Safari
        %p Or try Apple's Safari web browser, another very popular and secure alternative.
        %a.pure-button.button-secondary{href:'#void'} Learn More
  - unless @browzer.ie?
    .box.pure-u-1-1.pure-u-md-1-5
      %a.box{href:'#void'}
        .browser-logo#ie
        %h5 Microsoft IE
        %p If you really must use MS IE, you should, at the very least, keep it up-to-date.
        %a.pure-button.button-secondary{href:'#void'} Ugh
  .pure-u-md-1-5
