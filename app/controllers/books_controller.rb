class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end


  def show
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id)
    else
       render:edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def create
    @book = Book.new(book_params)
    if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
    # URLを確認して（ルートに）アクsyoンに移動するcreateからshowに移動するrais routesで確認
    else
    @books = Book.all
    render :index
    # アクションは移動せずにcreateアクション内で無理やりindexのページを表示させている
    # indexに入っているものをrenderの前に入れてあげるあえて使うのは、エラーメッセージを保持するため・入力ができていた方の情報も保持される
    end
  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end


end
