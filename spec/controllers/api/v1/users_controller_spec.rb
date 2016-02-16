require 'spec_helper'
require 'pry'

describe Api::V1::UsersController do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :index, format: :json
      @user_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "response contains the users data" do
      expect(@user_response[0][:email]).to eql @user.email
      expect(@user_response[0][:auth_token]).to eql @user.auth_token
      expect(@user_response[0][:password_digest]).to eql @user.password_digest
    end
    it "response adds all users" do
      expect(@user_response.length).to eq(1)
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show ,id: @user.id, format: :json
      @user_response = JSON.parse(response.body, symbolize_names: true)
    end
    context "when route is successfully accessed" do
      it "response contains the user data" do
        expect(@user_response[:email]).to eql @user.email
        expect(@user_response[:auth_token]).to eql @user.auth_token
        expect(@user_response[:password_digest]).to eql @user.password_digest
      end
      it "response not empty" do
        expect(@user_response.empty?).to be(false)
      end

      it { should respond_with 200 }
    end
    context "when NOT successfully accesed" do
      it "can´t route to a non-existing show-user-action" do
        expect(get: :show,id: 4).not_to be_routable
      end
    end
  end

end #describe Api::V1::UsersController 