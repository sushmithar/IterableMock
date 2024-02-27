require 'httparty'

class EventApiService
  include HTTParty

  BASE_URL = 'https://api.iterable.com'

  def initialize
    @api_key = "QWERTYUIVBNMLKJHG" # considering some text as api key
    @campaignId = 1 # considering campaign with ID 1 as default option
    @templateId = 1 # considering template with ID 1 as default option
  end

  def add_user_event(user_params, event_params, event_type)
    self.class.post("#{BASE_URL}/api/events/track", {
        body: {
            "email": user_params[:email],
            "userId": user_params[:id],
            "eventName": event_params[:name],
            "id": "",
            "createdAt":  Time.now,
            "dataFields": { event_type: event_type},
            "campaignId": @campaignId,
            "templateId": @templateId,
            "createNewFields": true
          }.to_json,
        headers: {'Content-Type' => 'application/json', 'API-Key': @api_key}
    } )
  end
  
  def fetch_user_events(email)
    self.class.get("#{BASE_URL}/api/events/#{email}", {
        headers: {'Content-Type': 'application/json', 'API-Key': @api_key}
    } )
  end

  def send_mail(current_user)
    self.class.post("#{BASE_URL}/email/target",{
      body: {
        "campaignId": @campaignId,
        "recipientEmail": current_user.email,
        "recipientUserId": current_user.id.to_s,
        "dataFields": {},
        "sendAt": DateTime.now.strftime("%Y-%m-%d %I:%M:%S").to_s,
        "allowRepeatMarketingSends": false,
        "metadata": {}
      },
      headers: {'Content-Type': 'application/json', 'API-Key': @api_key}
    })
  end

end