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
      params.require(:book).permit(:title, :description, :author, :category_id)
    end

    # before action-defined
    def find_book
      @book = Book.find(params[:id])
    end
end
