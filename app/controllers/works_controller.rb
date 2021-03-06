class WorksController < ApplicationController
  def index
    @album = Work.select { |item| item.category == "album"}
    @movie = Work.select { |item| item.category == "movie"}
    @book = Work.select { |item| item.category == "book"}
    @current_user = User.find_by(id:session[:user_id])
  end

  # we should actually make them inactive instead of deleting them
  # options: delete it's associated votes, will user still exist? yes if you use: user has many works through votes, and not belongs to
  def destroy
    work = Work.find_by(id: params[:id].to_i)
    work.destroy
    redirect_to root_path
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end


  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      render :notfound, status: :notfound
    end
  end

  def new
    @work = Work.new
  end


  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:sucess] = "#{@work.category} added sucessfully"
      redirect_to works_path
    else
      flash.now[:warning] = "#{@work.category} not created"
      render :new
    end
  end

  def upvote
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])

    if @user
      vote = Vote.new
      #(work_id:@work.id, user_id:@user.id)
      vote.work_id = @work.id
      vote.user_id = @user.id
      vote.save
      if vote.save
        flash[:sucess] = "sucessfully upvoted"
        redirect_to works_path(@work)
      else
        flash[:sucess] = "you already voted for this item"
        redirect_to works_path(@work)
      end

    else
      flash[:error] = "you are not logged in"
      redirect_to sessions_login_path
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description, :user_id)
  end
end
