require "rails_helper"

RSpec.describe "Discover Page" do 
  before(:each) do 
    @user_1 = User.create!(name: "Joe Smith", email: "joey_smithy@yahooey.com")
    @user_2 = User.create!(name: "Sam Smith", email: "sam_smithy@yahooey.com")

    @viewing_party_1 = ViewingParty.create!(duration_of_party: 300, when: "2023-12-25", start_time: "10:10")
    @viewing_party_2 = ViewingParty.create!(duration_of_party: 280, when: "2439-10-31", start_time: "11:48")

    @user_1.viewing_party_users.create!(viewing_party: @viewing_party_1, is_host: false)
    @user_1.viewing_party_users.create!(viewing_party: @viewing_party_2, is_host: true)

    visit "/users/#{@user_1.id}/discover"
  end

  describe "when visiting  '/users/:id/discover' " do 
    it "should have a button to discover top rated movies" do 
      expect(page).to have_button("Find Top Rated Movies")
    end

    xit "should have a text field to enter keywords to search by movie title" do 
      within(".movie_search") do
        expect(page).to have_field(:name)
      end
    end

    xit "should have a button to search by movie title" do 
      within(".movie_search") do
        expect(page).to have_button("Find Movies")
      end
    end
  end
end