class Xml2Json < Sinatra::Base

  before do
    content_type :json 	
  end

  get '/' do
    if params['url']
      callback = params.delete('callback')
      response = HTTParty.get(params['url'])
      r = response.dup.to_json
      if callback
        content_type :js
        return "#{callback}(#{r})"
      end
      r
    else
      content_type :html
      %Q(
      <!DOCTYPE html>
      <html lang="en">
      <head><title>XML2JSONP API Proxy</title></head>
      <body>
      <h1>XML2JSONP API Proxy</h1>
      <code>required params['url'] and params['callback']</code><p>
      <a href='http://github.com/bitzesty/xml2jsonp'>http://github.com/bitzesty/xml2jsonp</a>
      by <a href='http://bitzesty.com'>Bit Zesty - Ruby on Rails, London UK</a></p>
      </body>
      </html>
      )
    end
  end

  post '/' do
    url = params.delete('url')
    callback = params.delete('callback')
    response = HTTParty.post(url, params)
    r = response.dup.to_json
    "#{params['callback']}(#{r})"
  end

  put '/' do
    url = params.delete('url')
    callback = params.delete('callback')
    response = HTTParty.put(url, params)
    r = response.dup.to_json
    "#{params['callback']}(#{r})"
  end

  delete '/' do
    url = params.delete('url')
    callback = params.delete('callback')
    response = HTTParty.delete(url, params)
    r = response.dup.to_json
    "#{params['callback']}(#{r})"
  end

end

