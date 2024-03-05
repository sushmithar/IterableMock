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
      let (:create_events_body) {create_events.body}
      # let(:user) {{email: "sushmitha0614@gmail.com", id: 0}}  for invalid user id
      # let(:user) {{email: "abcd", id: 1}} for invalid email adress

      before do
        allow(JSON).to receive(:parse)
        JSON.parse(create_events_body)
      end
  
      it 'parses the iterable response for creating user events' do
        expect(JSON).to have_received(:parse).with(create_events_body)
      end

      #to check the response code for invalid user
      it 'error message for invalid user for creating user events' do
        expected_result = {
          "msg": "string",
          "code": "InvalidUserIdError",
          "params": {}
        }.to_json

        expect(create_events_body).to eql(expected_result)
      end
        
      #to check the response code for invalid email
      it 'error message for invalid email for creating user events' do
        expected_result = {
          "msg": "string",
          "code": "InvalidEmailAddressError",
          "params": {}
        }.to_json

        expect(create_events_body).to eql(expected_result)
      end
    end

    describe 'send_mail_for_event_b' do
      let(:user) {{email: "sushmitha0614@gmail.com", id: "1"}}
      # let(:user) {{email: "sushmitha0614@gmail.com", id: 0}}  for invalid user id
      # let(:user) {{email: "abcd", id: 1}} for invalid email adress
      let(:send_mail) { EventApiService.new.send_mail(user) }
      let (:send_mail_body) {send_mail.body}

      before do
        allow(JSON).to receive(:parse)
        JSON.parse(send_mail_body)
      end

      #to check the json respone from httparty response
      it 'parses the iterable response for send mail' do
        expect(JSON).to have_received(:parse).with(send_mail_body)
      end
        
      #to check the response code for invalid user
      it 'error message for invalid user for send mail' do
        expected_result = {
          "msg": "string",
          "code": "InvalidUserIdError",
          "params": {}
        }.to_json

        expect(send_mail_body).to eql(expected_result)
      end
        
      #to check the response code for invalid email
      it 'error message for invalid user for send mail' do
        expected_result = {
          "msg": "string",
          "code": "InvalidEmailAddressError",
          "params": {}
        }.to_json

        expect(send_mail_body).to eql(expected_result)
      end
    end
end