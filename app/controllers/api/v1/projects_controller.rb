class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project.as_json, status: :created # 201
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project.as_json, status: :ok # 200
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: @project.as_json, status: :ok # 200
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :user_id, :tag, :image, :portfolio_url)
  end
end
