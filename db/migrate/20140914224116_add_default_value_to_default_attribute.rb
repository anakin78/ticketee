class AddDefaultValueToDefaultAttribute < ActiveRecord::Migration
	def up
	  change_column :states, :default, :boolean, :default => false
	end

	def down
	  change_column :states, :default, :boolean, :default => nil
	end
end
