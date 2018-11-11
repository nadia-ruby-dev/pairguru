FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.word }
    movie
    user
  end
end
