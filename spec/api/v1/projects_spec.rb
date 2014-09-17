require "spec_helper"

describe "/api/v1/projects", type: :api do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:token) { user.authentication_token }
	let(:project) { FactoryGirl.create(:project) }

	puts :user

	before do
		user.permissions.create!(action: "view", thing: project)
	end

	context "projects viewable by this user" do
		let(:url) { "/api/v1/projects" }

		it "json" do
			get "#{url}.json", token: token
			projects_json = Project.all.to_json
			puts '#projects_json'
			puts '#' + projects_json
			last_response.body.should eql(projects_json)
			puts '#last_response.body'
			puts '#' + last_response.body
			last_response.status.should eql(200)
			projects = JSON.parse(last_response.body)
			
			projects.any? do |p|
				p["name"] == project.name
			end.should be_truthy
		end
	end
	
	context "projects viewable by this user" do
		before do
			FactoryGirl.create(:project, name: "Access Denied")
		end

		let(:url) { "/api/v1/projects" }

		it "json" do
			get "#{url}.json", token: token
			projects_json = Project.for(user).all.to_json
			puts '#projects_json'
			puts '#' + projects_json
			last_response.body.should eql(projects_json)
			puts '#last_response.body'
			puts '#' + last_response.body
			last_response.status.should eql(200)
			projects = JSON.parse(last_response.body)
			
			projects.any? do |p|
				p["name"] == "Access Denied"
			end.should be_falsey
		end
	end

	context "creating a project" do

		before do
			user.admin = true
			user.save
		end

		let(:url) { "/api/v1/projects" }
		it "successful JSON" do
			post "#{url}.json", :token => token,
								:project => {
								:name => "Inspector"
								}
			project = Project.find_by_name!("Inspector")
			route = "/api/v1/projects/#{project.id}"
			last_response.status.should eql(201)
			last_response.headers["Location"].should eql(route)
			last_response.body.should eql(project.to_json)
		end

		it "unsuccessful JSON" do
			post "#{url}.json",  token:  token,
								project: {
									:name => ""
								}
			last_response.status.should eql(422)
			errors = {"errors" => { "name" => ["can't be blank"] }}.to_json
			last_response.body.should eql(errors)
		end
	end
end
