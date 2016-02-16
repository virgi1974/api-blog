FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    auth_token "4J-f5HEHeDL_W9-dospW"
  end
end