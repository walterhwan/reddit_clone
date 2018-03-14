class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    @current_user = user
    session[:session_token] = user.reset_token
  end

  def logged_in?
    !!current_user
  end

  def log_out
    current_user.reset_token
    session[:session_token] = nil
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def require_moderator
    sub_topic = Sub.find(params[:id])
    unless current_user.id == sub_topic.moderator_id
      flash[:errors] = ['You cannot do that if you are not the moderator']
      redirect_to sub_url(sub_topic)
    end
  end

  def require_author
    post = Post.find(params[:id])
    unless current_user.id == post.author_id
      flash[:errors] = ['You cannot do that if you are not the author']
      redirect_to post_url(post)
    end
  end
end
