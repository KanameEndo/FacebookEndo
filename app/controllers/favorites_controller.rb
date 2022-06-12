class FavoritesController < ApplicationController
    def create
        favorite = current_user.favorites.create(blog_id: params[:blog_id])
        redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんの記事をお気に入り登録しましたぜ"
    end

    def destroy
        favorite = current_user.favorites.find_by(id: params[:id]).destroy
        redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんの記事を気に入らないので解除しました"
    end
end
