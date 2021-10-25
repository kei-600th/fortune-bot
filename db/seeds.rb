# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


p "create Images"
Image.create!(
  img:File.open("./public/images/aries.jpeg")
)
Image.create!(
  img:File.open("./public/images/taurus.jpeg")
)
Image.create!(
  img:File.open("./public/images/gemini.jpeg")
)
Image.create!(
  img:File.open("./public/images/cancer.jpeg")
)
Image.create!(
  img:File.open("./public/images/leo.jpeg")
)
Image.create!(
  img:File.open("./public/images/virgo.jpeg")
)
Image.create!(
  img:File.open("./public/images/libra.jpeg")
)
Image.create!(
  img:File.open("./public/images/scorpius.jpeg")
)
Image.create!(
  img:File.open("./public/images/sagittarius.jpeg")
)
Image.create!(
  img:File.open("./public/images/capricornus.jpeg")
)
Image.create!(
  img:File.open("./public/images/aquarius.jpeg")
)
Image.create!(
  img:File.open("./public/images/pisces.jpeg")
)