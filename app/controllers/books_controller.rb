class BooksController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]
  # impressionist :actions => [:index] #pv数表示のためのもの


  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
   to  = Time.current.at_end_of_day
   from  = (to - 6.day).at_beginning_of_day
   @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size }
   @user = current_user
   @book = Book.new
  end

  def show
    @book = Book.new
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    @book =Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      @user = current_user
      @book_detail = Book.find(params[:id])
      render :edit
    end
  end

   def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
   end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
