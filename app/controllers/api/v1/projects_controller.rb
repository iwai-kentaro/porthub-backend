class Api::V1::ProjectsController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    @projects = Project.all
    render json: @projects.map { |project| project_response(project) }
  end

  def show
    @project = Project.find(params[:id])
    render json: project_response(@project)
  end

  def create
    @project = Project.new(project_params)
    if params[:project][:image].present?
      @project.image.attach(params[:project][:image])
    end

    if @project.save
      render json: project_response(@project), status: :created # 201
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: project_response(@project), status: :ok # 200
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: project_response(@project), status: :ok # 200
    else
      render json: @project.errors, status: :unprocessable_entity # 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :user_id, :image, :portfolio_url, tag: [])
  end

  def project_response(project)

    project.as_json(only: [:id, :title, :description, :portfolio_url, :user_id])
    .merge({
      tag: project.tag_array,
      image_url: project.image.attached? ? url_for(project.image) : nil
    })
  end
end
