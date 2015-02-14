class ToadsController < ApplicationController
  before_action :logged_in_user?
  before_action :correct_user?
  
  def create
    @project = Project.find(params[:project_id])
    @toad = @project.toads.create(toad_params) if user_signed_in?
    redirect_to project_path(@project)
  end
  
  def destroy    
    @project = Project.find(params[:project_id])
    @toad = Toad.find(params[:id])
    @toad.delete
    redirect_to @project
  end
  
  private
  
  def toad_params
    params.require(:toad).permit(:description, :complete)
  end
  
  def logged_in_user?
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
  def correct_user?
    @project = current_user.projects.find_by(id: params[:project_id])
    redirect_to root_url if @project.nil? 
  end
end
