class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  
  def index
    # if nothing is selected in category
    if params[:category].blank?
    # order by newest
      @books = Book.all.order("created_at DESC")
    else
      # set the category id equaly to the id of the book
      @category_id = Category.find_by(name: params[:category]).id
      # set books = to the range of items where the @category_id in the database is equal to the one selected in @category_id via dropdown
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  # will show individual books
  def show
    if @book.reviews.blank?
      # if no reviews set this val to none
      @average_review = 0;
    else
      # round the reviews by half a star approx
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  def new
    # instance variable - what is used in the views
    # @book = associated with the current user
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]
    # @book = associated with the current user
    if @book.save
      # successful book add sends user back to index page
      redirect_to root_path
    else
      # otherwise, render a new form
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @book.category_id = params[:category_id]
    # select the specific book user is editing along with all it's associated data in book_params
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    # sends user back to index page
    redirect_to root_path
  end


  private
    # when a user sends information, this params holds that data from some form
    def book_params
      params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end

    # before action-defined
    def find_book
      @book = Book.find(params[:id])
    end
end
