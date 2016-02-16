require 'spec_helper'
require 'pry'

describe Api::V1::UsersController do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :index
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

end #describe Api::V1::UsersController 