# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 10.times do |user|
#   User.create(name: "User#{user}", email: "user#{user}@test.com", password: "password", password_confirmation: "password")
# end

# create a main sample user
User.create!(name: "Example User",
              email: "example@railstutorial.org",
              password: "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

# generate a bunch of additional users
39.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

# generate microposts for a subset of users
users = User.order(:created_at).take(6)
25.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# generate following relationships
users = User.all
user = users.first
following = users[2..20]
followers = users[3..25]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
