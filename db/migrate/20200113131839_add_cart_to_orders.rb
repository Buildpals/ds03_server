class AddCartToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :cart, null: true, foreign_key: true
  end
end
