class ResponsesController < ApplicationController
  before_action :set_post
  before_action :set_response, only: [:update, :destroy]

  def create
    @response = Response.new(response_params)
    @response.user_id = current_user.id
    @response.post_id = @post.id

    if @response.save
      redirect_to :back, notice: "Response '@response.title' was successfully created!"
    else
      render :post_path(@post)
    end
  end

  def update
    if @response.update(response_params)
      redirect_to :back, notice: "Response '#{@response.title}' was successfully updated!"
    else
      render :post_path(@post)
    end
  end

  def destroy
    response_title = @response.title
    if @response.destroy
      redirect_to :back, notice: "Response '#{response_title}' was successfully deleted!"
    else
      render :post_path(@post)
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
