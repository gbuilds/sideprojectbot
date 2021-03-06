class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :logged_in_user?, only: [:edit, :update, :destroy, :show]
  before_action :correct_user?, only: [:edit, :update, :destroy, :show]

  respond_to :html

  def index
    if user_signed_in?
      @projects = current_user.projects
    else
      @projects = Project.all
      #TODO make this show only public projects and allow private/public projects
    end
    respond_with(@projects)
  end

  def show
    @project = Project.find(params[:id])
    @toads = @project.toads.all
  end

  def new
    @project = current_user.projects.build
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.save
    respond_with(@project)
  end

  def update
    @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
  
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
  
  def logged_in_user?
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
  def correct_user?
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil? 
  end
  
end
