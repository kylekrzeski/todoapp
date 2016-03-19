class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  
  validates_length_of :content, :maximum => 160
  #methods for our model
  
  #if completed it means that the completed_at field is not blank
  def completed?
    !completed_at.blank?
  end
  
end
