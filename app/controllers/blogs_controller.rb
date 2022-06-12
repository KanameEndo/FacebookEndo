class BlogsController < ApplicationController
  def index
    @blogs = current_user.blogs
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
    render :new
    else
    if @blog.save
      redirect_to blogs_path, notice: "投稿しました！"
    else
      render :new
      end
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました"
  end

  private
  def blog_params
  params.require(:blog).permit(:title, :content, :user_id, :image, :image_cache)
  end
end
