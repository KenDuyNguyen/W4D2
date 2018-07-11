# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'date'

class Cat < ApplicationRecord
  
  COLORS =  %w(white black brown)
  
  validates :color, presence: true, inclusion: { in: COLORS, 
    message: "%{value} is not a valid color" }
  validates :sex, presence: true, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }
  validates :birth_date, :name, :description, presence: true
  
  has_many :cat_rental_requests, dependent: :destroy
  
  def age 
    curr = DateTime.now.strftime("%Y/%m/%d")
    yr, m, d = curr.split("/")
    yr1, m1, d1 = birth_date.split("/")
    age = yr.to_i - yr1.to_i
  
    if m1 = m && d > d1
      age + 1
    elsif m > m1
      age + 1
    else
      age
    end
  end 
  
end
