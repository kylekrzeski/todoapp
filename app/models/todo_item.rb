class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  
  #methods for our model
  
  #if completed it means that the completed_at field is not blank
  def completed?
    !completed_at.blank?
  end
  
end
