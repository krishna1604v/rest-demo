class User < ApplicationRecord

    validates :username, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true

end
