require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "is not valid if pw and pw confirmation do not match" do
      @user = User.create(first_name: "Minh", last_name: "Vo", email: "minh@test.com", password: "123456", password_confirmation: "12345")

      expect(@user).to_not be_valid
    end

    it "is not valid if email is not unique" do
      @user = User.create(first_name: "Minh", last_name: "Vo", email: "minh@test.com", password: "123456", password_confirmation: "123456")
      @user2 = User.create(first_name: "Minh", last_name: "Vo", email: "MINH@TEST.com", password: "123456", password_confirmation: "123456")

      expect(@user).to be_valid
      expect(@user2).to_not be_valid
    end

    it "is not valid without email, first name and last name" do
      @user = User.create(first_name: "Minh", last_name: "Vo", password: "123456", password_confirmation: "123456")
      @user2 = User.create(last_name: "Vo", email: "minh@test.com",  password: "123456", password_confirmation: "123456")
      @user3 = User.create(first_name: "Minh", email: "minh@test.com", password: "123456", password_confirmation: "123456")

      expect(@user).to_not be_valid
      expect(@user2).to_not be_valid
      expect(@user3).to_not be_valid
    end

    it "is not valid if password length shorter than 6 characters" do
      @user = User.new(first_name: "Minh", last_name: "Vo", password: "123", password_confirmation: "123")

      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "can login with white spaces in email" do
      @user = User.create(first_name: "Minh", last_name: "Vo",email: "minh@test.com", password:"123456", password_confirmation:"123456")

      expect(User.authenticate_with_credentials(" minh@test.com   ", "123456")).to eq(@user)
    end

    it "can login with not case sensitive email" do
      @user = User.create(first_name: "Minh", last_name: "Vo", email: "minh@test.com", password:"123456", password_confirmation:"123456")

      expect(User.authenticate_with_credentials("MINH@TEST.com", "123456")).to eq(@user)
    end

    it "can login with correct credentials" do
      @user = User.new(first_name: "Minh", last_name: "Vo", email: "minh@test.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(User.authenticate_with_credentials("minh@test.com", "123456")).to be_truthy
    end

  end
end