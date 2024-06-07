class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true,
            length: { in: 10..16 },
            format: {
              with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*(.)\1{2,}).*\z/,
              message: 'must have at least 10 characters and at most 16 characters, contain at least one lowercase character, one uppercase character and one digit, and cannot contain three repeating characters in a row'
            }
end
