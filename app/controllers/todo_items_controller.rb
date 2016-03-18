class TodoItemsController < ApplicationController
  #before anything happens we are setting the todo_list to the current list the user is on
  before_action :set_todo_list
  #this sets a before_action for the todo_item for every method except for the create method
  #Why? because the item is not already in the list so it won't be able to find it
  before_action :set_todo_item, except: [:create]
  
  def create
    #@todo_item is the list item that the user is about to create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    
    redirect_to @todo_list
  end
  
  def complete
    #when the user clicks complete, we will get the current time and put that value in the completed_at field in the database
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item completed!"
  end
  
  
  def destroy
    #the before_action basically finds the todo_item id for this list and deletes it if it finds it
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
  
  def set_todo_item
    #@todo_item is the item(s) in the list that is being displayed or that the user has clicked on
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
  
  #we are using permit content because they will only be able to add the content to the database
  #(we don't want the user to be able to change the elapsed time, etc)
  def todo_item_params
    params[:todo_item].permit(:content)
  end

  
end
