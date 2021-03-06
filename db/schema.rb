# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150204151921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "options", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
    t.string   "name"
  end

  add_index "options", ["poll_id"], name: "index_options_on_poll_id", using: :btree

  create_table "polls", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "owner_id"
    t.boolean  "closed",          default: false
    t.string   "guest_token"
    t.boolean  "secret",          default: false
    t.boolean  "allow_anonymous", default: true
  end

  create_table "polls_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "polls_users", ["user_id", "poll_id"], name: "index_polls_users_on_user_id_and_poll_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   default: "User"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "username"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
    t.string   "guest_token"
  end

  add_index "votes", ["poll_id"], name: "index_votes_on_poll_id", using: :btree
  add_index "votes", ["user_id", "option_id"], name: "index_votes_on_user_id_and_option_id", unique: true, using: :btree

end
