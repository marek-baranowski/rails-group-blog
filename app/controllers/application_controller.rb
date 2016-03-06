class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private
  def not_authenticated
    flash[:alert] = 'You have to authenticate to access this page.'
    redirect_back_or_default
  end

  def redirect_back_or_default(default = root_url)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to default
  end
end
