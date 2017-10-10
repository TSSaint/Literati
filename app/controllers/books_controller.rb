class BooksController < ApplicationController
  
  def index
    # order by newest
    @books = Book.all.order("created_at DESC")
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

  private
    # when a user sends information, this params holds that data from some form
    def book_params
      params.require(:book).permit(:title, :description, :author)
    end

end
