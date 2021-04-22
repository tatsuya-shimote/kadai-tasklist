class TasksController < ApplicationController
  before_action :set_task , only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in , only: [:index, :show]
  before_action :correct_user, only:[:destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)  # form_with 用
    
    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクを登録できませんでした"
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = '正常に訂正されました'
      redirect_to @task
    else
      flash.now[:danger] = '訂正できませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = '正常に削除されました'
    redirect_to tasks_url
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
