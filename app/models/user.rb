class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    @user = self.find_by_email(email.strip.downcase)

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end