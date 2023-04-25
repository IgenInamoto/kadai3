class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  
  def show
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
        @Users = User.all
        
        render "edit"
    end
  end
  
  def index
    @user = current_user
    @users = User.all
    @books = Book.all
    @book = Book.new
  end
  
  
   private

  def book_params
     params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
end
  

