class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :has_reviewed, only: [:new]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id

    # associate current review with book and user

    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_book
      @book = Book.find(params[:book_id])
      # find current book that the review is associated with it
    end

    def find_review
      @review = Review.find(params[:id])
    end

    def has_reviewed
    if current_user.reviews.exists?(book: @book)
      redirect_to book_path(@book), notice: "You've already reviewed this book. You may edit your old review."
    end
  end
end
