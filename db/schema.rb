# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_01_27_031347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "answers", id: :serial, force: :cascade do |t|
    t.integer "quiz_result_id"
    t.integer "questions_id"
    t.integer "options_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "item_price_cents"
    t.integer "total_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "options", id: :serial, force: :cascade do |t|
    t.integer "questions_id", null: false
    t.text "content", null: false
    t.string "option_letter", limit: 1, null: false
    t.boolean "correct", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_charge_id"
    t.string "email"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "price_cents"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.integer "quizzes_id"
    t.text "content", null: false
    t.integer "question_order", null: false
  end

  create_table "quiz_result", id: :serial, force: :cascade do |t|
    t.integer "quizzes_id"
    t.integer "user_id"
    t.integer "score"
  end

  create_table "quizzes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "user_id"
    t.boolean "private"
  end

  create_table "user", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "options", column: "options_id", name: "answers_options_id_fkey", on_delete: :cascade
  add_foreign_key "answers", "questions", column: "questions_id", name: "answers_questions_id_fkey", on_delete: :cascade
  add_foreign_key "answers", "quiz_result", name: "answers_quiz_result_id_fkey", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "options", "questions", column: "questions_id", name: "options_questions_id_fkey", on_delete: :cascade
  add_foreign_key "products", "categories"
  add_foreign_key "questions", "quizzes", column: "quizzes_id", name: "questions_quizzes_id_fkey", on_delete: :cascade
  add_foreign_key "quiz_result", "\"user\"", column: "user_id", name: "quiz_result_user_id_fkey", on_delete: :cascade
  add_foreign_key "quiz_result", "quizzes", column: "quizzes_id", name: "quiz_result_quizzes_id_fkey", on_delete: :cascade
end
