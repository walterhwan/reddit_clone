class PostsController < ApplicationController

  before_action :require_login
  before_action :require_author, only: [:edit, :update]

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
  end

  def create
    # params = {:title: "Tommy", :url, :content, sub_ids: []}

    @post = Post.new(post_params)
    # post = Post.new
    # post.title=("Tommy")
    # post.sub_ids = ["", "1", "2"]
    # @post = current_user.posts.new(post_params)

    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]

    # @post.post_subs.each do |ps|
    #   ps.save
    #   ps.post_id
    #   ps.post
    # end
    # ps = @post.post_subs.new
    # ps.post #=> @post

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
