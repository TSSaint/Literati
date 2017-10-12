class ReviewsController < ApplicationController
  before_action :find_book

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.book_id
    @review.user_id = current_user.id

    # associate current review with book and user

    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_book
      @book = Book.find(params[:book_id])
      # find current book that the review is associated with it
    end

end
