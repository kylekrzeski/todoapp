class TodoList < ActiveRecord::Base
  has_many :todo_items
  
  validates_length_of :description, :maximum => 160
  validates_length_of :title, :maximum => 60
  
end
