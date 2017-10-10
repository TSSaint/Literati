class Book < ApplicationRecord
  # users have multiple books
  belongs_to :user
end
