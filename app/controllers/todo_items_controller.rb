class TodoItemsController < ApplicationController
  #before anything happens we are setting the todo_list to the current list the user is on
  before_action :set_todo_list
  
  def create
    #@todo_item is the list item that the user is about to create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    
    redirect_to @todo_list
  end
  
  def destroy
    #this basically finds the todo_item id for this list and deletes it if it finds it
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted."
    else
      flash[:error] = "Todo List item could not be deleted."
    end
    
    #this knows to redirect to the todo_list 'homepage' that the todo_item was in 
    redirect_to @todo_list
  end
  
  
  
  #START PRIVATE METHODS
  private
  
  def set_todo_list
    #@todo_list is the list that the user is currently on
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  
  #we are using permit content because they will only be able to add the content to the database
  #(we don't want the user to be able to change the elapsed time, etc)
  def todo_item_params
    params[:todo_item].permit(:content)
  end

  
end
