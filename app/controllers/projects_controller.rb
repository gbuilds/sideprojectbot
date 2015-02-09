class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user?, only: [:edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    if user_signed_in?
      @projects = current_user.projects
    else
      @projects = Project.all
      #TODO make this show only public projects and allow private projects
    end
    respond_with(@projects)
  end

  def show
    respond_with(@project)
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
    unless current_user.id == @project.user.id
      flash[:warning] = "Unauthorized action"
      redirect_to projects_path
    end
  end
  
end
