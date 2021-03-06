class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authorize, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @responses = @post.responses
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post '#{@post.title}' was successfully created!"
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post '#{@post.title}' was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    post_title = @post.title
    if @post.destroy
      redirect_to posts_path, notice: "Post '#{post_title}' was successfully deleted!"
    else
      redirect_to :back
    end
  end

  def upvote
    @post.liked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @post.disliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :body)
  end
end
