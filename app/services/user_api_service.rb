require 'httparty'

class UserApiService
  include HTTParty

  BASE_URL = 'https://api.iterable.com/'

  def initialize
    @api_key = "qwertyuiofhjk"
  end

  def add_user(email)
    self.class.post("#{base_url}api/users/update", {
        body: { "email": email, "mySettings": {"email": true}, "dataFields": {}}.to_json,
        headers: {'Content-Type': 'application/json', 'API_Key': @api_key}
    } )
  end
  
  def fetch_user(email)
    self.class.get("#{base_url}api/users/#{email}", {
        headers: {'Content-Type': 'application/json', 'API_Key': @api_key}
    } )
  end

  def delete_user(email)
    self.class.delete("#{base_url}api/users/#{email}", {
        headers: {'Content-Type': 'application/json',  'API_Key': @api_key}
    } )
  end
end