class AddZincProductOffersToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :zinc_product_offers, :json
  end
end
