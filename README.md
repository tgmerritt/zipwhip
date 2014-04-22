I'm still really new to this :)

ZipWhip has an API that is used widely as an SMS platform for land-line numbers.  I plan to continuously implement all the functionality their API offers.

A couple notes - the gem is available on RubyGems.org - so just 'gem install zipwhip' and you should have it.

This is my second gem - and I've written it the way I know how to write gems, which means using a lot of 'self.' tags on the methods as I never quite grasped why making a variable an instance of the class was better?  But anyway - please feel free to do with this as you like.  I'm happy to give something back to someone.

You should authenticate by calling ZipWhip.login(username,password) from your application.  This will set a session token for ZipWhip so you only have to auth once per session.  I recommend you setup environment variables and then call that from your application such that you don't checkin actual usernames and passwords to version control.  Something like username = ENV["ZIPWHIP_USERNAME"]; password = ENV["ZIPWHIP_PASSWORD"]; ZipWhip.login(username,password)

The usage as of right now is :  ZipWhip.send_new_sms(to,msg)

The FROM number will automatically be the number of the account you're logged in as.  Part of sending an SMS with ZipWhip is authenticating through a login request, which is ZipWhip.login.  It will use the environment variables setup already for authentication, and then you'll have to store the token that they return.  I've done this in a step that sets session[:zw_token] and then use the 'token' variable to call that from the ZipWhip class.  You need to somehow capture the token or no subsequent ZipWhip API call will work.  

The TO will be the number that you wish to send the SMS to - keeping in mind this is a US-only service right now.

Phone number formats are accepted as '+1XXXXXXXXXX' with the Internationally-accepted + and country code.  I don't know if this is the only way they accept it.  It's the first way I tried it and it's working fine.

The message will be any string.  Be careful if you're going to pass the + as a parameter from some on-click event, you have to encode that and then decode it.  Probably easier to add the +1 to the params[:from] or whatever then send that.