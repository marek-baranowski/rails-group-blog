class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def not_authenticated
    flash[:alert] = "You have to authenticate to access this page."
    redirect_back_or_default
  end

  def admin_only
    unless current_user.admin?
      common_access_denial_action
    end
  end

  def owns_resource
    unless current_user.id.to_s == params[:id] || current_user.admin?
      common_access_denial_action
    end
  end

  def redirect_back_or_default(default = root_url)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to default
  end

  def common_access_denial_action
    flash[:alert] = 'Access denied.'
    redirect_back_or_default
  end
end
