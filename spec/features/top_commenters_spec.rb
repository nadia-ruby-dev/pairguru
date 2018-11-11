require "rails_helper"

RSpec.feature "Top commenters", type: :feature do
  let!(:user_1) { FactoryBot.create(:user_with_comments, comments_count: 5) }
  let!(:user_2) { FactoryBot.create(:user_with_comments, comments_count: 9) }
  let!(:user_3) { FactoryBot.create(:user_with_comments, comments_count: 20) }
  let!(:comment) { FactoryBot.create(:comment, created_at: Time.zone.now - 8.days) }

  scenario "Users with most comments for the last 7 days are displayed" do
    visit "movies/top_commenters"

    aggregate_failures do
      within(".table") do
        expect(page).to have_content("5")
        expect(page).to have_content("9")
        expect(page).to have_content("20")
        expect(page).not_to have_content("1")
      end
    end
  end
end
