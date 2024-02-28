require 'httparty'

class UserApiService
  include HTTParty

  BASE_URL = 'https://api.iterable.com/'

  def initialize
    @api_key = "qwertyuiofhjk"
  end

  def add_user(email)
    self.class.post("#{BASE_URL}api/users/update", {
        body: { "email": email, "mySettings": {"email": true}, "dataFields": {}}.to_json,
        headers: {'Content-Type': 'application/json', 'API_Key': @api_key}
    } )
  end
  
  def fetch_user(email)
    self.class.get("#{BASE_URL}api/users/#{email}", {
        headers: {'Content-Type': 'application/json', 'API_Key': @api_key}
    } )
  end

  def delete_user(email)
    self.class.delete("#{BASE_URL}api/users/#{email}", {
        headers: {'Content-Type': 'application/json',  'API_Key': @api_key}
    } )
  end
end