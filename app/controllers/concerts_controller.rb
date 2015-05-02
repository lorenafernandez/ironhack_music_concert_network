class ConcertsController < ApplicationController

	def index
		@concerts = Concert.all.what_is_happening_today
		@concerts_last_mont = Concert.all.what_is_happening_last_month
	end

	def new
		@concert = Concert.new
	end

	def create
		@concert = Concert.new(entry_params)
		if @concert.save
			redirect_to concert_path(@concert)
		else
			render 'new'
		end
	end

	def show
		@comment = Comment.new
		render ('concert_not_found') unless (@concert = Concert.find_by id: params[:id])

	end

	def show_most_popular
		
		@concerts = Concert.all.where("date>?", Date.today)
		ids = []
		how_many_comments_concerts = []
		@concerts.each do |concert|
			binding.pry
			how_many_comments = concert.comments.length
			concert.comments.each do |comment_id|
				ids << comment_id.id
			end
		end
		@comments = @concerts.comments
	end

	private
	def entry_params
		params.require(:concert).permit(:band,:venue,:city,:date,:price,:description)
	end
end
