class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created book successfully."
      redirect_to post_path(@post.id)
    else
      @user = current_user
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
    @user = current_user
    
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @user = @post.user
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :image, :caption)
  end
  
  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end
end
