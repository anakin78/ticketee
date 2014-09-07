FactoryGirl.define do
	factory :user do
		name "Example project"
		email "sample@example.com"
		password "optimusprime"
		password_confirmation "optimusprime"

		factory :admin_user do
			admin true
		end
	end
end
