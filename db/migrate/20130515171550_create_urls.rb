class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |url|
      url.string  :url
      url.string  :code
      url.integer :clicks, :default => 0
      url.integer :user_id
    end  
  end
end

