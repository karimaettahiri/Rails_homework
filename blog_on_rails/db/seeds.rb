# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Post.destroy_all


50.times do 
    created_at = Faker::Date.backward(days: 365 * 2)
    p = Post.create(
        title: Faker::Lorem.word,
        body: Faker::Lorem.paragraph,
        created_at: created_at,
        updated_at: created_at
    ) 
    if p.valid?
        rand(1..6).times do 
            Comment.create(body:Faker::Lorem.paragraph,post:p)
        end
    end
end
    
    

comments = Comment.all
posts = Post.all
puts comments.count
puts posts.count

