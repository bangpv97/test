User.create!(name:  "Admin",
             email: "admin@admin.org",
             password: "admin123",
             password_confirmation: "admin123",
<<<<<<< HEAD
             admin: true)
=======
<<<<<<< HEAD
             admin: true)
=======
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
>>>>>>> Chapter 11: Account activation
>>>>>>> Chapter 11: Account activation

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
<<<<<<< HEAD
               password_confirmation: password)
=======
<<<<<<< HEAD
               password_confirmation: password)
=======
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)

>>>>>>> Chapter 11: Account activation
>>>>>>> Chapter 11: Account activation
end
