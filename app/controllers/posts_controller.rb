class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_post, only: %i[edit update destroy]

  after_action :verify_authorized, only: %i[edit update destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post deleted!'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def find_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
