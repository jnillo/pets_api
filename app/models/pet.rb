class Pet < ActiveRecord::Base
  #relations
  belongs_to :user

  #Validations
  validates :name,presence: true
  validates :birthdate,presence: true
  validates :rate,presence: true
  validates :sex,presence: true
  validates :user_id, presence: true

  #Macros
  PETS_TYPE={0 => "Rat",1 => "Dog",2 => "Chinchilla"}
  PETS_SEX = {0 => "Male", 1=> "Female"}

  #Methods
  def to_json
    {:name => self.name,
     :years => ((Time.now-self.birthdate.to_time)/1.year).round.to_s,
     :sex =>PETS_SEX[self.sex],
     :pet_type => PETS_TYPE[self.pet_type],
     :rate => self.rate
      }.to_json
  end
end
