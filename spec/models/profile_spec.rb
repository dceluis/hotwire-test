require 'rails_helper'
require 'faker'

describe Profile, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }

  describe "email" do
    it "should be valid" do
      email = Faker::Internet.email
      profile = Profile.new(email: email)
      profile.valid?
      expect(profile.errors[:email]).to be_empty
    end

    it "should be invalid" do
      profile = Profile.new(email: "luis@bad_email")
      profile.valid?
      expect(profile.errors[:email]).to_not be_empty
    end
  end

  describe "phone" do
    it "should be valid" do
      # Faker gives random phone numbers including ones in the wrong format
      # eg. 1-555-555-5555, +1 (555) 555-5555, (555)555-5555, 5555555555
      # Right now, we're not doing anything to transform the phone number to a
      # valid format, so we're just going to test a known valid format
      # phone = Faker::PhoneNumber.cell_phone
      phone = Faker::Base.numerify('###-###-####')
      profile = Profile.new(phone: phone)
      profile.valid?
      expect(profile.errors[:phone]).to be_empty
    end

    it "should be invalid" do
      phone = Faker::Base.numerify('##########')
      profile = Profile.new(phone: phone)
      profile.valid?
      expect(profile.errors[:phone]).to_not be_empty
    end
  end

  it { should validate_length_of(:first_name).is_at_most(25) }
  it { should validate_length_of(:last_name).is_at_most(50) }

  describe "full_name" do
    it "should return the full name" do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      profile = Profile.new(first_name: first_name, last_name: last_name)
      expect(profile.full_name).to eq("#{first_name} #{last_name}")
    end
  end
end
