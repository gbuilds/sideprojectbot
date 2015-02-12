class ToadsController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    @toad = @project.toads.create(toad_params) if user_signed_in?
    redirect_to project_path(@project)
  end
  
  private
  
  def toad_params
    params.require(:toad).permit(:description, :complete)
  end
end
