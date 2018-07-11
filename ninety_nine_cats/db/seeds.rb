# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null

Cat.destroy_all 
garfield = Cat.create(name: "Garfield", sex: "M", birth_date: '2015/01/20', description: "Laziest cat in the world", color: 'white')

CatRentalRequest.destroy_all
r1 = CatRentalRequest.create(cat_id: garfield.id, start_date: '2015/01/20', end_date: '2016/01/20')
