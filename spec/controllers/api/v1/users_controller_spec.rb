require 'spec_helper'
require 'pry'

describe Api::V1::UsersController do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :index, format: :json
    end

    it "response contains the users data" do
      expect(json_response[0][:email]).to eql @user.email
      expect(json_response[0][:auth_token]).to eql @user.auth_token
      expect(json_response[0][:password_digest]).to eql @user.password_digest
    end
    it "response adds all users" do
      expect(json_response.length).to eq(1)
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show ,id: @user.id, format: :json
    end
    context "when route is successfully accessed" do
      it "response contains the user data" do
        expect(json_response[:email]).to eql @user.email
        expect(json_response[:auth_token]).to eql @user.auth_token
        expect(json_response[:password_digest]).to eql @user.password_digest
      end
      it "response not empty" do
        expect(json_response.empty?).to be(false)
      end

      it { should respond_with 200 }
    end
    context "when NOT successfully accesed" do
      it "can´t route to a non-existing show-user-action" do
        expect(get: :show,id: 4).not_to be_routable
      end
    end
  end

  describe "POST #create" do

    context "when a user is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes } 
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(json_response[:email]).to eql @user_attributes[:email]
      end
      it "creates an auth_token before creating the user" do
        user_response = json_response
        expect(json_response[:auth_token].empty?).to be(false) 
      end

      it { should respond_with 201 } # user created!
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { user: @invalid_user_attributes } #, format: :json
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:email]).to include "can't be blank"
      end

      it { should respond_with 422 } # Unprocessable Entity !
    end
  end

  describe "PUT/PATCH #update" do

    # before(:each) do
    #   @user = FactoryGirl.create :user
    # end

    context "when is successfully updated" do

      before(:each) do
        @user = FactoryGirl.create :user
        user_params = { email: "newmail@example.com", password: "12345678", password_confirmation: "12345678" }
        patch :update, { id: @user.id, user: user_params } , format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 } # successful response
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        user_params = { email: "bademail.es", password: "12345678", password_confirmation: "12345678" }
        patch :update, { id: @user.id, user: user_params } , format: :json
      end

       it "renders an errors json" do
          user_response = json_response
          expect(user_response[:email]).to eq(["is invalid"])
       end

       it { should respond_with 422 }
     end

   end


end #describe Api::V1::UsersController 











