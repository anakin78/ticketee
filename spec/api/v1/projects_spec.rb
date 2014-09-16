require "spec_helper"

describe "/api/v1/projects", type: :api do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:token) { user.authentication_token }
	let(:project) { FactoryGirl.create(:project) }

	puts :user.to_yaml

	before do
		user.permissions.create!(action: "view", thing: project)
	end

	context "projects viewable by this user" do
		let(:url) { "/api/v1/projects" }

		it "json" do
			get "#{url}.json", token: token
			projects_json = Project.all.to_json
			last_response.body.should eql(projects_json)
			last_response.status.should eql(200)
			projects = JSON.parse(last_response.body)
			
			projects.any? do |p|
				p["name"] == project.name
			end.should be_true
		end
	end
end
