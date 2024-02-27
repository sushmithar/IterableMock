class EventsController < ApplicationController
    def index
        user_events = EventApiService.new.fetch_user_events(current_user.email)
        if user_events[:events].present?
           @events = user_events["events"]
        else
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
