class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate!
   authenticate_or_request_with_http_token do |token, options|
      @user = User.where(auth_token: token).first
    end
  end
end
