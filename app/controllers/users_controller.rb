class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  
  def show
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @book = Book.new
    @books = @user.books
  end
  
    # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_user
  end
  
  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @user = user.follower_user
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
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end
  

