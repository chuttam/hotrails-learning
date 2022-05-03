class Task < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # Note: There are asynch alternatives to these methods e.g. #broadcast_prepend_later_to
  # #broadcast_remove_later_to doesn't exist since once deleted, there's nothing left to retrieve, and start asynchronously.
  # after_create_commit -> { broadcast_prepend_to "tasks", partial: "tasks/task", locals: { task: self }, target: "tasks" }
  # after_update_commit -> { broadcast_replace_to "tasks", partial: "tasks/task", locals: { task: self }, target: "tasks" }
  # after_destroy_commit -> { broadcast_remove_to "tasks", partial: "tasks/task", locals: { task: self }, target: "tasks" }

  # Equivalent to above
  broadcasts_to ->(task) { "tasks" }, inserts_by: :prepend
end
