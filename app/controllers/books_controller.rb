class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  
  def index
    # order by newest
    @books = Book.all.order("created_at DESC")
  end

  # will show individual books
  def show
  end

  def new
    # instance variable - what is used in the views
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # successful book add sends user back to index page
      redirect_to root_path
    else
      # otherwise, render a new form
      render 'new'
    end
  end

  def edit
  end

  def update
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
      params.require(:book).permit(:title, :description, :author)
    end

    # before action-defined
    def find_book
      @book = Book.find(params[:id])
    end
end
