class AddStatusToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :status, :string, default: "active"
  end
end
