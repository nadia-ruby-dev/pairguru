class CommentsController < ApplicationController
  before_action :set_movie

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment has been created. Please note: to add a new comment, you need to delete your previous comment."
      redirect_to @movie
    else
      redirect_to @movie
    end
  end

  def destroy
    @comment = @movie.comments.where(user_id: current_user.id).first
    @comment.destroy

    flash[:alert] = "Comment has been deleted."
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
