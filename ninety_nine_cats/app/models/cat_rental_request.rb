# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  STATUS_TYPES = %w(PENDING APPROVED DENIED)
  validates :status, presence: true, inclusion: { in: STATUS_TYPES, 
    message: "%{value} is not a valid status" }
  validates :cat_id, :start_date, :end_date, presence: true
  
  belongs_to :cat
  
  def overlapping_requests
    ActiveRecord::Base.connection.execute(<<-SQL)
      SELECT
        *
      FROM
        cat_rental_requests
      WHERE 
        cat_id = '#{cat_id}' 
          AND 
          (start_date BETWEEN '#{start_date}' AND '#{end_date}') 
          OR  
          (end_date BETWEEN '#{start_date}' AND '#{end_date}') 
    SQL
  end
end
