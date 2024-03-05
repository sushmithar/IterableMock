require 'rails_helper'

describe UserApiService do
  describe 'add_user_by_email' do
    let(:add_user) { UserApiService.new.add_user_by_email("sushmitha0614@gmail.com") }
    let(:add_user_body) {add_user.parsed_response}

    before do
      allow(JSON).to receive(:parse)
      JSON.parse(add_user_body)
    end

    it 'parses the iterable response for add user' do
      expect(JSON).to have_received(:parse).with(add_user_body)
    end
  end

  describe 'add_user_by_userId' do
    let(:add_user) { UserApiService.new.add_user_by_userId("1") }
    let(:add_user_body) {add_user.parsed_response}

    before do
      allow(JSON).to receive(:parse)
      JSON.parse(add_user_body)
    end

    it 'parses the iterable response for add user' do
        puts add_user_body
      expect(JSON).to have_received(:parse).with(add_user_body)
    end

    it 'error message for already add user' do
      expected_result = {
        "msg": "string",
        "code": "UserIdAlreadyExists",
        "params": {}
      }.to_json

      expect(add_user_body).to eql(expected_result)
    end
  end
end

