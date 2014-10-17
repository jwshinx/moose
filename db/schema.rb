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

ActiveRecord::Schema.define(version: 0) do

  create_table "data_unit_events", force: true do |t|
    t.string    "data_unit_name", null: false
    t.text      "old_exception"
    t.text      "new_exception"
    t.string    "old_event"
    t.string    "new_event"
    t.timestamp "new_timestamp",  null: false
    t.string    "host"
    t.string    "user"
    t.text      "metadata"
    t.datetime  "old_timestamp",  null: false
  end

  add_index "data_unit_events", ["data_unit_name"], name: "fk_du_event", using: :btree

  create_table "data_unit_events_test", force: true do |t|
    t.string    "data_unit_name", null: false
    t.text      "old_exception"
    t.text      "new_exception"
    t.string    "old_event"
    t.string    "new_event"
    t.timestamp "new_timestamp",  null: false
    t.string    "host"
    t.string    "user"
    t.text      "metadata"
    t.datetime  "old_timestamp",  null: false
  end

  add_index "data_unit_events_test", ["data_unit_name"], name: "fk_du_event", using: :btree

  create_table "data_units", primary_key: "name", force: true do |t|
    t.timestamp "last_updated",             null: false
    t.datetime  "date_shipped"
    t.datetime  "date_received"
    t.string    "driver_name",   limit: 50
    t.string    "city",          limit: 50
    t.string    "country",       limit: 50
    t.string    "rig_id",        limit: 50
    t.integer   "data_size"
    t.integer   "bundle_size",   limit: 8
    t.string    "ingestion",     limit: 50
    t.string    "fallout",       limit: 50
    t.string    "current_event"
  end

  create_table "data_units_test", primary_key: "name", force: true do |t|
    t.timestamp "last_updated",             null: false
    t.datetime  "date_shipped"
    t.datetime  "date_received"
    t.string    "driver_name",   limit: 50
    t.string    "city",          limit: 50
    t.string    "country",       limit: 50
    t.string    "rig_id",        limit: 50
    t.integer   "data_size"
    t.integer   "bundle_size",   limit: 8
    t.string    "ingestion",     limit: 50
    t.string    "fallout",       limit: 50
  end

  create_table "drive_session_events", force: true do |t|
    t.string    "drive_session_name", null: false
    t.text      "old_exception"
    t.text      "new_exception"
    t.string    "old_event"
    t.string    "new_event"
    t.timestamp "new_timestamp",      null: false
    t.string    "host"
    t.string    "user"
    t.text      "metadata"
    t.datetime  "old_timestamp",      null: false
  end

  add_index "drive_session_events", ["drive_session_name"], name: "fk_ds_event", using: :btree

  create_table "drive_sessions", primary_key: "name", force: true do |t|
    t.timestamp "last_updated",              null: false
    t.string    "rig_id",         limit: 6
    t.string    "du_id"
    t.string    "server_version", limit: 20
    t.integer   "capture_count"
    t.datetime  "start_time"
    t.datetime  "end_time"
    t.string    "current_event"
  end

  create_table "drive_sessions_test", primary_key: "name", force: true do |t|
    t.timestamp "last_updated",              null: false
    t.string    "rig_id",         limit: 6
    t.string    "du_id"
    t.string    "server_version", limit: 20
    t.integer   "capture_count"
    t.datetime  "start_time"
    t.datetime  "end_time"
  end

  create_table "processing", id: false, force: true do |t|
    t.string "DriveSessionId", limit: 20
    t.date   "ProcessDate"
    t.string "Status",         limit: 20
  end

  create_table "qa_annotations", force: true do |t|
    t.string   "drive_session_id"
    t.string   "description"
    t.boolean  "q1",               default: false
    t.boolean  "q2",               default: false
    t.boolean  "q3",               default: false
    t.boolean  "q4",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qa_annotations", ["drive_session_id"], name: "fk_qa_annotations", using: :btree

  create_table "results", id: false, force: true do |t|
    t.string    "drive_session_name",            null: false
    t.string    "test_type",                     null: false
    t.string    "severity",           limit: 50
    t.string    "reason_unchecked"
    t.string    "app",                           null: false
    t.string    "app_version",        limit: 20
    t.timestamp "creation_date",                 null: false
  end

  add_index "results", ["drive_session_name"], name: "fk_results1", using: :btree

  create_table "results_qa", force: true do |t|
    t.string    "drive_session_name", null: false
    t.string    "issue_type",         null: false
    t.timestamp "created_at",         null: false
  end

  add_index "results_qa", ["drive_session_name"], name: "fk_results_qa", using: :btree

  create_table "results_temp", id: false, force: true do |t|
    t.string    "drive_session_name",            null: false
    t.string    "test_type",                     null: false
    t.string    "severity",           limit: 50
    t.string    "reason_unchecked"
    t.string    "app",                           null: false
    t.string    "app_version",        limit: 20
    t.timestamp "creation_date",                 null: false
  end

  add_index "results_temp", ["drive_session_name"], name: "fk_results1", using: :btree

  create_table "results_test", id: false, force: true do |t|
    t.string    "drive_session_name",            null: false
    t.string    "test_type",                     null: false
    t.string    "severity",           limit: 50
    t.string    "reason_unchecked"
    t.string    "app",                           null: false
    t.string    "app_version",        limit: 20
    t.timestamp "creation_date",                 null: false
  end

  add_index "results_test", ["drive_session_name"], name: "fk_results1", using: :btree

  create_table "rolled_up_stats", primary_key: "metric", force: true do |t|
    t.integer   "actual",       null: false
    t.integer   "possible",     null: false
    t.float     "percent",      null: false
    t.timestamp "last_updated", null: false
  end

  create_table "transfer_queue", primary_key: "drive_session_id", force: true do |t|
    t.integer  "data_unit_id",                                  null: false
    t.integer  "minor_upload_id",        limit: 8,              null: false
    t.datetime "minor_upload_timestamp"
    t.string   "minor_upload_status",    limit: 20,             null: false
    t.string   "minor_upload_path",                             null: false
    t.integer  "minor_upload_failures",             default: 0, null: false
    t.integer  "raw_upload_id",          limit: 8
    t.datetime "raw_upload_timestamp"
    t.string   "raw_upload_status",      limit: 20,             null: false
    t.string   "raw_upload_path",                               null: false
    t.integer  "raw_upload_failures",               default: 0, null: false
    t.integer  "aspera_machine_index"
  end

end
