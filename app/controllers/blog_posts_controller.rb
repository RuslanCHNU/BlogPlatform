class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /blog_posts or /blog_posts.json
  def index
    @blog_posts = BlogPost.order(created_at: :desc)  # This orders the posts by creation date in descending order
  end
  

  # GET /blog_posts/new
  def new
    @blog_post = BlogPost.new
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end
  
  def edit
    @blog_post = current_user.blog_posts.find(params[:id])
  end

  # POST /blog_posts or /blog_posts.json
  def create
    @blog_post = current_user.blog_posts.new(blog_post_params)
  
    if @blog_post.save
      redirect_to @blog_post, notice: 'Blog post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /blog_posts/1 or /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to blog_post_url(@blog_post), notice: "Blog post was successfully updated." }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /blog_posts/1 or /blog_posts/1.json
  def destroy
    @blog_post = current_user.blog_posts.find(params[:id])
  
    if @blog_post.destroy
      redirect_to blog_posts_path, notice: 'Blog post was successfully destroyed.'
    else
      redirect_to @blog_post, alert: 'Error deleting blog post.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :content, :user_id)
    end
end
