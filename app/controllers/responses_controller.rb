class ResponsesController < ApplicationController
  before_action :set_post, only: [:new, :create]
  before_action :set_response, only: [:edit, :update, :destroy, :upvote, :downvote]

  def new
    @response = @post.responses.build
    @response.user = current_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @response = @post.responses.build(response_params)
    @response.user = current_user

    if @response.save
      redirect_to :back, notice: "Response '@response.title' was successfully created!"
    else
      redirect_to :back
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @response.update(response_params)
      redirect_to :back, notice: "Response '#{@response.title}' was successfully updated!"
    else
      redirect_to :back
    end
  end

  def destroy
    response_title = @response.title
    if @response.destroy
      redirect_to :back, notice: "Response '#{response_title}' was successfully deleted!"
    else
      redirect_to :back
    end
  end

  def upvote
    @response.liked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @response.disliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(:title, :content)
  end
end
