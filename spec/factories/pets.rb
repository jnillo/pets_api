require 'factory_girl'

FactoryGirl.define do
  factory :pet do
    name "Tana"
    sex "female"
    rate 90.0
    birthdate "2013-05-18"
  end

  factory :pet_2,class: Pet do
    name "Toby"
    sex "male"
    rate 95.0
    birthdate "2010-05-18"
  end
end