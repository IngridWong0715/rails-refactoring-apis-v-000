class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create

    github_helper = GithubService.new
    github_helper.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])

    session[:token] = github_helper.access_token
    session[:username] = github_helper.get_username

    redirect_to '/'
  end
end
