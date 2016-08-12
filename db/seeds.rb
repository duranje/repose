# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def weekday_sample
	(0..6).to_a.sample
end

def radio_sample
	(0..4).to_a.sample
end

def random_hour
	(0..2).to_a.sample
end

def random_user
	User.limit(1).order("RANDOM()").first
end

def random_lifeline
	Lifeline.limit(1).order("RANDOM()").first
end

def random_time
	Date.today - (10000*rand())
end

unless Rails.env.production?

	User.delete_all
	Event.delete_all
	Survey.delete_all
	Lifeline.delete_all
	Availability.delete_all

	10.times do
		User.create!(
			first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			email: Faker::Internet.email,
			password:'password'
			)
	end

	25.times do
		lifeline =	Lifeline.create!(
			first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			phone: Faker::PhoneNumber.phone_number,
			user_id: random_user.id
			)

		if lifeline.id
			rand_hour = random_hour
			Availability.create!(
				start_hour: rand_hour,
				end_hour: (rand_hour + (1..4).to_a.sample),
				weekday: weekday_sample,
				lifeline_id: lifeline.id
				)
		end
	end



	200.times do
		event =	Event.create!(
			user_id: random_user.id,
			start_time: random_time,
			end_time: random_time
			)
		if event.id
			Survey.create!(
				severity: radio_sample,
				comments: Faker::Lorem.paragraph,
				event_id: event.id
				)
		end
	end
end

