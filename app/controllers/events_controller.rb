class EventsController < ApplicationController
    def index
        user_events = EventApiService.new.fetch_user_events(current_user.email)
        if user_events[:events].present?
           @events = user_events["events"] #If respone is in JSON then parse it
        else
           #  AS of now respone is in hash 
           ## <HTTParty::Response:0xc198 parsed_response={"msg"=>"Invalid API key", "code"=>"BadApiKey",
           #   "params"=>{"ip"=>"49.207.243.61", "endpoint"=>"/api/events/sushmitha0614@gmail.com"}},
           #    @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>,
           #    @headers={"date"=>["Tue, 27 Feb 2024 14:52:18 GMT"], "con
          flash[:warning] = user_events["msg"]
        end
    end

    def create_events
        @event = EventApiService.new.add_user_event(current_user, params[:event], params[:button])
        flash[:notice] =  @event["code"]
        redirect_to action: "index"
    end

    def send_mail(current_user, event)
        @event = EventApiService.new.send_mail(current_user, params[:event])
    end
end
