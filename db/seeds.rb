# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(name: "Daggie", email: "stickandprey@gmail.com", password: "password", pronouns: "She, They", phone_number: "7066127089", personal_note: "", admin: true)
user.save
user = User.new(name: "Joy", email: "joy@mail.com", password: "password", pronouns: "They, Her", phone_number: "**********", personal_note: "")
user.save
user = User.new(name: "Scrum", email: "scrum@mail.com", password: "password", pronouns: "He, Him", phone_number: "**********", personal_note: "")
user.save
user = User.new(name: "Blumble", email: "blumble@mail.com", password: "password", pronouns: "She, He, They", phone_number: "**********", personal_note: "")
user.save
user = User.new(name: "Kriik", email: "kriik@mail.com", password: "password", pronouns: "I, Me", phone_number: "**********", personal_note: "")
user.save

