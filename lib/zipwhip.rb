class ZipWhip
  # include ActionView::Helpers::NumberHelper
  require 'erb'
  require 'net/http'
  require 'uri'
  require 'openssl'
  require 'json'

  def self.login
    uri = "https://api.zipwhip.com/user/login?username="+ENV["ZIPWHIP_USERNAME"]+"&password="+ENV["ZIPWHIP_PASSWORD"]
    # params = { :username => ENV["ZIPWHIP_USERNAME"], :password => ENV["ZIPWHIP_PASSWORD"] }
    # uri.query = URI.encode_www_form(params)
    sms_header(uri)
    response = @http.request(@request)
    # puts "response key is " + response.body
    res = JSON.parse(response.body)
    return res
  end

  def self.send_new_sms(to,msg,token)
    uri = "https://api.zipwhip.com/message/send?session="+token+"&body="+msg+"&contacts=ptn:/"+to
    sms_header(uri)
    # @request.body = ({"from" => from, "to" => to, "message" => msg})
    # puts @request.body
    response = @http.request(@request)
    # puts response.body
  end

  def self.sms_header(uri)
    # uri = URI.parse("https://api.zipwhip.com/message/send")
    uri = URI.parse(uri)
    # Full control
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @request = Net::HTTP::Post.new(uri.request_uri)
    # @request["Accept"] = "text/json"
    # @request["Content-Type"] = "text/json"
    # @request.basic_auth(ENV['ZIPWHIP_USERNAME'],ENV['ZIPWHIP_PASSWORD'])
    return @request
  end

end