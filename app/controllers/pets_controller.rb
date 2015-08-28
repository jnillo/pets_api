class PetsController < ApplicationController
  before_filter :authenticate!

  def show
    pet = Pet.where(id: params[:id]).first
    if pet
      render json: pet.to_json
    else
      render status: :not_found
    end
  end

  def create
    pet_attributes = extract_attributes(params)
    if @user.pets.create(pet_attributes)
      render json: {:message => "You pet was created successfull."}, status: :found
    else
      render json: {:message => "We couldn't created you pet, please review the attributes and try again."}, status: :not_found
    end
  end

  def update
    pet_attributes = extract_attributes(params)
    pet = @user.pets.where(:id => params[:id]).first
    if pet
      if pet.update_attributes(pet_attributes)
        render json: {:message => "You pet was updated successfull."}, status: :found
      else
        render json: {:message => "We couldn't updated you pet, please review the attributes and try again."}, status: :not_found
      end
    else
      render json: {:message => 'Pet not found.'},status: :not_found
    end
  end

  def destroy
    pet = @user.pets.where(:id => params[:id]).first
    if pet
      pet.destroy
      render json: {:message => 'Your pet was removed successfull.'},status: :found
    else
      #The user can't know that this id exist
      render json: {:message => 'Pet not found.'},status: :not_found
    end
  end

  private

  def extract_attributes(params)
    attributes = {}
    attributes[:name] = params[:name] if params[:name]
    attributes[:sex] = convert_sex(params[:sex]) if params[:sex]
    attributes[:pet_type] = convert_pet_type(params[:pet_type]) if params[:pet_type]
    attributes[:birthdate] = extract_birthdate(params[:years]) if params[:years]
    attributes[:rate] = params[:rate] if params[:rate]
    attributes
  end

  def extract_birthdate(years)
    (DateTime.now-years.to_i.years)
  end

  def convert_sex(sex)
    Pet::PETS_SEX.invert[sex.camelcase]
  end

  def convert_pet_type(pet_type)
    Pet::PETS_TYPE.invert[pet_type.camelcase]
  end

end
