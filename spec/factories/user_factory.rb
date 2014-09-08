FactoryGirl.define do
	sequence(:email) {|n| "user#{n}@example.com" }

	factory :user do
		name "username"
		email { generate(:email) }
		password "optimusprime"
		password_confirmation "optimusprime"

		factory :admin_user do
			admin true
		end
	end
end
