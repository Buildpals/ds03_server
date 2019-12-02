class CreateDatabaseTables < ActiveRecord::Migration[6.0]
  def change

    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"

    create_table "orders", force: :cascade do |t|
      t.bigint "product_id"
      t.bigint "user_id"
      t.string "chosen_offer_id"
      t.integer "quantity", default: 1, null: false
      t.integer "delivery_method", default: 0, null: false
      t.string "full_name"
      t.string "address"
      t.integer "region", default: 0, null: false
      t.string "city_or_town"
      t.string "phone_number"
      t.string "email"
      t.string "txtref"
      t.integer "status", default: 0, null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["product_id"], name: "index_orders_on_product_id"
      t.index ["user_id"], name: "index_orders_on_user_id"
    end

    create_table "products", force: :cascade do |t|
      t.string "item_url"
      t.integer "item_quantity"
      t.integer "delivery_method", default: 0
      t.integer "delivery_region", default: 0
      t.json "zinc_product_details"
      t.string "full_name"
      t.string "phone_number"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.json "zinc_product_offers"
      t.string "chosen_offer_id"
      t.string "email"
      t.string "txtref"
      t.integer "status", default: 0
      t.string "address"
      t.string "city_or_town"
    end

    create_table "users", force: :cascade do |t|
      t.string "full_name", null: false
      t.string "phone_number", null: false
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.boolean "admin", default: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end

    create_table "versions", force: :cascade do |t|
      t.string "item_type", null: false
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.text "object"
      t.datetime "created_at"
      t.text "object_changes"
      t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    end

    add_foreign_key "orders", "products"
    add_foreign_key "orders", "users"
  end
end