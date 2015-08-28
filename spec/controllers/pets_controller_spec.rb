require 'rails_helper'

describe "Pets controller" ,type: :api do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @pet = FactoryGirl.create(:pet,:user_id => @user.id)
    @user_2 = FactoryGirl.create(:user_2)
  end

  it "Get info about a pet" do
    get "pets/#{@user.pets.first.id}",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user.auth_token}
    last_response.status.should eql(200)
    json = JSON.parse(last_response.body)
    expect(json['name']).to eq(@pet.name)
  end

  it "Update a pet" do
    put "pets/#{@pet.id}?name=Mandragora",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user.auth_token}
    last_response.status.should eql(302)
    json = JSON.parse(last_response.body)
    expect(json['message']).to eq('You pet was updated successfull.')
    @pet.reload
    expect(@pet.name).to eq("Mandragora")
  end

  it "Create a pet" do
    post "/pets?name=Tano&years=2&pet_type=Rat&rate=25.0&sex=Male",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user_2.auth_token}
    last_response.status.should eql(302)
    json = JSON.parse(last_response.body)
    expect(json['message']).to eq("You pet was created successfull.")
    expect(Pet.last).to eq(@user_2.pets.last)
  end

  it "Destroy a pet" do
    delete "pets/#{@user.pets.first.id}",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user.auth_token}
    last_response.status.should eql(302)
    json = JSON.parse(last_response.body)
    expect(json['message']).to eq('Your pet was removed successfull.')
  end

  it "Get info about a pet of other user" do
    get "pets/#{@user.pets.first.id}",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user_2.auth_token}
    last_response.status.should eql(200)
    json = JSON.parse(last_response.body)
    expect(json['name']).to eq(@pet.name)
  end
  #
  it "Try to destroy a pet of other user" do
    delete "pets/#{@user.pets.first.id}",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user_2.auth_token}
    last_response.status.should eql(404)
    json = JSON.parse(last_response.body)
    expect(json['message']).to eq('Pet not found.')
  end

  it "Try to modify a pet of other user" do
    put "pets/#{@pet.id}?name=Mandragora",{},{ 'HTTP_AUTHORIZATION' => 'Token token='+@user_2.auth_token}
    last_response.status.should eql(404)
    json = JSON.parse(last_response.body)
    expect(json['message']).to eq('Pet not found.')
    @pet.reload
    expect(@pet.name).to eq("Tana")
  end

end
