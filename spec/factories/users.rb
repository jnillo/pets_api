require 'factory_girl'

FactoryGirl.define do

  factory :user do
   name "Cesar"
   surname "Millan"
   email "cesar@millan.com"
   encrypted_password "$2a$10$yVSn6U3KoZB9ybUMniEO6O7lg/XN1V6Be20Snql.iJL0yeu81lcLi"
   auth_token "2KzCaZBdgpKlpw=1"
  end

  factory :user_2,class: User do
    name "Glenn"
    surname "Quagmire"
    email "elhombreQ@tomatoma.com"
    encrypted_password "$2a$10$yVSn6U3KoZB9ybUMniEO6O7lg/XN1V6Be20Snql.iJL0yeu81lcLi"
    auth_token "2KzCaZBdgpKlpw=2"
  end
end