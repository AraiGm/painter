class PostsController < ApplicationController
    before_action :ensure_correct_user,{only:[:edit,:update,:destroy]}
    before_action :authenticate_user

  def index
  @posts=Post.all.order(created_at: :desc)
  end

  def show
    @post=Post.find_by(id:params[:id])
    @user=@post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def show_image
    @post=Post.find_by(id:params[:id])
    send_data @post.illust,:type => 'image/jpeg',:disposition =>'inline'
  end

  def new
   @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content],
      title: params[:title],
      illust: params[:illust].read,
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/s17874ty/painter/posts/index")
    else
      render("/s17874ty/painter/posts/new")
    end
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content=params[:content]
    @post.title=params[:title]
    if @post.save
      redirect_to("/s17874ty/painter/posts/index")
    else
      render("/s17874ty/painter/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/s17874ty/painter/posts/index")
  end

  def ensure_correct_user
  @post = Post.find_by(id: params[:id])
  if @post.user_id != @current_user.id
    flash[:notice] = "権限がありません"
    redirect_to("/s17874ty/painter/posts/index")
  end
end
end
