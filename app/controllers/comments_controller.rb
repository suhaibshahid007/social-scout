class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy]

  after_action :verify_authorized, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    authorize @comment
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
