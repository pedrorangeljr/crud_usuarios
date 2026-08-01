class User < ApplicationRecord
  validates :nome,
            presence: true

  validates :email, presence: true, uniqueness: true

  validates :idade, numericality: { greater_than: 0 }
end
