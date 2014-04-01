module Deardetector
  module Devices
    
    # Controller methods available in views
    def self.included(c)
      c.helper_method :browser_segment
    end
    
    def browser_segment
      fallback_segment = "desktop"
      timeout_after_seconds = 6
      cookie_expires = 1.week.from_now
      
      # Allow overriding the segment value manually
      unless params[:segment].blank?
        session[:browser_segment] = params[:segment]
      end
      
      # Return cookie value if found
      return session[:browser_segment] if session[:browser_segment]
      
      user_agent = request.env['HTTP_USER_AGENT']
      host = request.env['SERVER_NAME']
      file = request.fullpath
      
      # Setup faraday
      options = {
        :headers => { 'Accept' => "application/xml; charset=utf-8" },
        :ssl => { :verify => false },
        :url => "http://detector.dearapi.com"
      }
      
      connection = Faraday::Connection.new(options) do |conn|
        conn.use Faraday::Request::UrlEncoded  # Encode request params as "www-form-urlencoded"
        conn.use Faraday::Response::Mashify    # Allow dot-syntax for objects
        conn.use Faraday::Response::ParseXml   # Auto parse as xml
        conn.use Faraday::Response::RaiseError # Raise exceptions on 40x, 50x responses
        conn.use Faraday::Response::Logger     # log the request to STDOUT
        conn.adapter(Faraday.default_adapter)
      end
      
      begin
        Timeout.timeout(timeout_after_seconds) do
          response = connection.get do |req|
            #http://devices.local/xml?ua=#useragent#&site=hvadhedderde.com&file=/index.php
            req.url '/xml/', :ua => user_agent
            req.params['site'] = host
            req.params['file'] = file
          end
          session[:browser_segment] = response.body.device.segment
        end
      rescue Timeout::Error => e
        return fallback_segment
      rescue
        return fallback_segment
      end
      
      return session[:browser_segment]
    end
    
  end
end