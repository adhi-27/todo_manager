class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: Todo.order(:due_date).map { |todo| todo.to_pleasant_string }.join("\n")
  end

  def show
    id = params[:id]
    todo = Todo.find(id)
    render plain: todo.to_pleasant_string
  end

  def create
    text = params[:todo_text]
    date = DateTime.parse(params[:due_date])
    new_todo = Todo.create!(todo_text: text, due_date: date, completed: false)
    response_text = "The new Todo is created with id #{new_todo.id}"
    render plain: response_text
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.find(id)
    todo.completed = completed
    todo.save
    render plain: "Updated #{id} todo status to #{completed}"
  end
end
