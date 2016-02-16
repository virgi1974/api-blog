require 'spec_helper'
require 'pry'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

# first test

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should respond_to(:password_digest) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

# shoulda matchers in action
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_presence_of(:password_digest) }


  it { should validate_presence_of(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) }



end