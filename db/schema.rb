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

ActiveRecord::Schema.define(version: 20140424091017) do

  create_table "enrollments", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "studentnumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "projectbundles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "signup_start"
    t.datetime "signup_end"
    t.boolean  "verified"
  end

  create_table "projectpictures", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maxstudents"
    t.integer  "user_id"
    t.integer  "projectbundle_id"
    t.string   "website"
    t.integer  "projectpicture_id"
  end

  create_table "signups", force: true do |t|
    t.integer  "enrollment_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.boolean  "status"
    t.boolean  "forced"
  end

  add_index "signups", ["enrollment_id"], name: "index_signups_on_enrollment_id"

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "accesslevel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "username"
    t.boolean  "disabled"
  end

end
