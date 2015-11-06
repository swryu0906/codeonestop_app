class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :body)
  end
end
