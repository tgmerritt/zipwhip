class ZipWhip
  require 'erb' # If you want to extend functionality to parse a template with ruby syntax
  require 'net/http'
  require 'uri'
  require 'openssl'
  require 'json'

  def self.login(u,p)
    uri = "https://api.zipwhip.com/user/login?username="+u+"&password="+p
    sms_header(uri)
    response = @http.request(@request)
    res = JSON.parse(response.body)
    return res
  end

  def self.send_new_sms(to,msg,token)
    uri = "https://api.zipwhip.com/message/send?session="+token+"&body="+msg+"&contacts=ptn:/"+to
    sms_header(uri)
    # puts @request.body
    response = @http.request(@request)
    # puts response.body
  end

  def self.sms_header(uri)
    uri = URI.parse(uri)
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @request = Net::HTTP::Post.new(uri.request_uri)
    return @request
  end

end