class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/i-am-an-aweome-post-man
  def show
    @post = Post.find_by(permalink: params[:id])
  end

  # GET /posts/new
  def new
    new_post
  end

  # GET /posts/1/edit
  def edit
    editable_post
  end

  def create
    if new_post(post_params).save
      redirect_to new_post, notice: 'Post was successfully created.' 
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    def editable_post
      @post ||= current_user.posts.find_by(permalink: params[:id])
    end

    def new_post(attrs={})
      @post ||= current_user.posts.new(attrs)
    end

    def post_params
      params.require(:post).permit(:title, :markdown, :published_at)
    end
end
