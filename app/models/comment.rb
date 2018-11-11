class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :movie_id, uniqueness: { scope: :user_id, message: "You've already reviewed this movie!"}
end
