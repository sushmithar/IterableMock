class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  after_create :add_user_to_iterable
  after_destroy :remove_user_from_iterable

  def add_user_to_iterable
    UserApiService.new.add_user(email)
  end

  def remove_user_from_iterable
    UserApiService.new.delete_user(email)
  end
end
