require "rails_helper"

RSpec.feature "Commenting on movies", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:movie) { FactoryBot.create(:movie) }

  before do
    login_as(user)
    visit "/movies"
    click_link(movie.title)
  end

  scenario "A user can leave only one comment per movie" do

    fill_in "Leave your comment", with: "Awesome movie!"
    click_button "Create comment"

    aggregate_failures do
      expect(page).to have_content "Comment has been created."
      expect(page).to have_content "Please note: to add a new comment, you need to delete your previous comment."
      expect(page).to have_content "Awesome movie!"
    end

    click_link "Delete comment"

    fill_in "Leave your comment", with: "I guess it's alright."
    click_button "Create comment"

    aggregate_failures do
      expect(page).to have_content "Comment has been created."
      expect(page).to have_content "I guess it's alright."
    end
  end

  private

  def login_as(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    find_link("Logout").visible?
  end
end
