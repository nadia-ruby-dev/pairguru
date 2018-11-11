FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@sample.com" }
    password "password"
    confirmed_at Time.zone.now

    factory :user_with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end
  end
end
