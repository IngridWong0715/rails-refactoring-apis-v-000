class RepositoriesController < ApplicationController
  def index
    if session[:token]
      binding.pry
      github_helper = GithubService.new({access_token: session[:token]})
    else
      github_helper = GithubService.new
    end
    binding.pry
    @repos_array = github_helper.get_repos
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
