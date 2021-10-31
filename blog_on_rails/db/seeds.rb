# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Comment.destroy_all
Post.destroy_all
PASSWORD = '123'
super_user = User.create(
    name: "Admin",
    email: "admin@gmail.com",
    password: PASSWORD,
    is_admin: true
)
5.times do 
    name = Faker::Name.first_name
  
    User.create(
        name:name,
        email: "#{name}@#{Faker::Name.last_name}.com",
        password: PASSWORD
    )
end


users = User.all

50.times do 
    created_at = Faker::Date.backward(days: 365 * 2)
    p = Post.create(
        title: Faker::Lorem.word,
        body: Faker::Lorem.paragraph,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
    ) 
    if p.valid?
        rand(1..6).times do 
            Comment.create(body:Faker::Lorem.paragraph,post:p , user: users.sample)
        end
    end
end
    
    

comments = Comment.all
posts = Post.all
puts users.count
puts comments.count
puts posts.count

