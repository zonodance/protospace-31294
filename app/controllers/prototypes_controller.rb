class PrototypesController < ApplicationController
  before_action :authenticate_user! , except:[:edit, :new, :destoroy]
  before_action :move_to_index, only: [:edit]
  def index
  @prototypes = Prototype.all
 end

 def new
  @prototype = Prototype.new
 end

 def create
   @prototype = Prototype.new(prototype_params)
   if @prototype.save
    redirect_to root_path
   else
     render :show
   end     
  end

 def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments
  # @comments = @tweet.comments.includes(:user)
  # @comment = Comment.all
 end

 def edit
  @prototype = Prototype.find(params[:id])
  # unless user_signed_in?
  #   redirect_to action: :index
  end
 end

 def update
  @prototype = Prototype.find(params[:id])
 if @prototype.update(prototype_params)
  redirect_to prototype_path(@prototype)
 else
  render :edit
 end
end

 def destroy
  prototype = Prototype.find(params[:id])
  prototype.destroy
  redirect_to root_path
 end

 private 
 def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
end
def move_to_index
  redirect_to root_path unless user_signed_in?
end

end