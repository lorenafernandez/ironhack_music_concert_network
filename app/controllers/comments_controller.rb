class CommentsController < ApplicationController
	def new
		@concert = Comment.find params[:concert_id]
		@comments = @concert.comments.order("date ASC")
	end

	def new
		@concert = Comment.find params[:concert_id]
		@comments = @concert.comments.order("date ASC")
	end

	def create
		@concert = Concert.find params[:concert_id]
		@comments = @concert.comments.new(entry_params)
		if @comments.save
			redirect_to concert_comment_path(@concert,@comments)
		else
			render 'new'
		end
	end

	def show
		@concerts = Concert.find params[:concert_id]
		@comments = @concerts.comments.order("date ASC")
	end

	def index
		@concerts = Concert.find params[:concert_id]
		@comments = @concerts.comments.order("date ASC")
	end

	private
	def entry_params
		params.require(:comment).permit(:content)
	end
end
