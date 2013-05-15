require 'faker'

20.times do
  User.create( :full_name => Faker::Name.name, :email => Faker::Internet.email, 
            :password => Faker::Lorem.characters(char_count = 5))

end
