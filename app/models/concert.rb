class Concert < ActiveRecord::Base

	has_many :comments

	validates :band, presence: true, format: {with: /\A[a-zA-Z0-9\s]+\z/}
	validates :venue, presence: true, format: {with: /\A[a-zA-Z0-9\s]+\z/}
	validates :city, presence: true, format: {with: /\A[a-zA-Z\s]+\z/}
	validates :date, presence: true
	validates :price, presence: true, numericality: true, inclusion: {in: 0..99999}
	validates :description, presence: true

	def self.what_is_happening_today
		self.where("date=?", Date.today)
	end

	def self.what_is_happening_last_month
		date_start = Date.new(Date.today.year, Date.today.month,1)
		date_end = date_start.next_month.prev_day + 1.day
		self.where("date>?", date_start).where("date<?", date_end)
	end

	def self.are_you_cheaper_than(price)
		self.where("price<?",price).where("date>?", Date.today)
	end
end
