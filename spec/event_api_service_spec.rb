require 'rails_helper'

describe EventApiService do
    describe 'fetch_events' do
      let(:fetch_user_events) { EventApiService.new.fetch_user_events("sushmitha0614@gmail.com") }

      before do
        allow(JSON).to receive(:parse)
        JSON.parse(fetch_user_events.parsed_response)
      end

       it 'parses the iterable response' do
        expect(JSON).to have_received(:parse).with(fetch_user_events.parsed_response)
      end
    end

    describe 'create_user_events' do
        let(:create_events) { EventApiService.new.add_user_event({email: "sushmitha0614@gmail.com", id: "1"},
                                {name: "example1"}, "event_b") }
        
        before do
          allow(JSON).to receive(:parse)
          JSON.parse(create_events.parsed_response)
        end
  
         it 'parses the iterable response' do
            puts create_events.parsed_response
          expect(JSON).to have_received(:parse).with(create_events.parsed_response)
        end
    end

    describe 'send_mail_for_event_b' do
        let(:user) {{email: "sushmitha0614@gmail.com", id: "1"}}
        let(:send_mail) { EventApiService.new.send_mail(user) }
        
        before do
          allow(JSON).to receive(:parse)
          JSON.parse(send_mail.parsed_response)
        end
  
         it 'parses the iterable response' do
          expect(JSON).to have_received(:parse).with(send_mail.parsed_response)
        end
    end

end