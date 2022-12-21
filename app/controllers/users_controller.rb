class UsersController < ApplicationController
  before_action :today_date

  def today_date
   @today_date = Time.zone.now
  end  

  def index
   @page_title = "予約一覧"
   @users = User.all
  end

  def new
   @page_title = "予約"
   @user = User.new
  end

  def create
   @user = User.new(params.require(:user).permit(
    :title, #タイトル
    :start_at, #開始日
    :end_at, #終了日
    :is_all_day, #終日
    :memo #スケジュールメモ
   ))
   if @user.save
     flash[:success] = "予約しました"
     redirect_to :users
   else
     flash[:failure] = "予約できませんでした"
     render "new"  
   end 
  end

  def show
   @page_title = "詳細"
   @user = User.find(params[:id])
  end

  def edit
   @page_title = "編集"
   @user = User.find(params[:id]) 
  end

  def update
   @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(
       :title, #タイトル
       :start_at, #開始日
       :end_at, #終了日
       :is_all_day, #終日
       :memo #スケジュールメモ
    )) 
    flash[:success] = "更新しました"
    redirect_to :users
    else
     flash[:failure] = "更新できませんでした"
     render "edit" 
    end
  end

  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:delete] = "削除しました"
   redirect_to :users
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def user_params
    params.require(:user).permit(:title, :start_date, :end_date, :all_day, :memo)
  end
end
