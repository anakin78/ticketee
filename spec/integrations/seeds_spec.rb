require 'spec_helper'

feature "Seed Data" do
	let!(:admin) { FactoryGirl.create(:admin_user) }
  	let!(:project) { FactoryGirl.create(:project) }

	scenario "The basics" do
		
		load Rails.root + "db/seeds.rb"

		sign_in_as!(admin)
		
	    click_link project.name
   		click_link "New Ticket"
    	fill_in "Title", with: "Comments with state"
    	fill_in "Description", with: "Comments always have a state."
    	click_button "Create Ticket"
    	within("#comment_state_id") do
	      expect(page).to have_content("New")
	      expect(page).to have_content("Open")
	      expect(page).to have_content("Closed")
    	end
  	end
end