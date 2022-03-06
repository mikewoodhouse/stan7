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

ActiveRecord::Schema.define(version: 2022_02_26_164854) do

  create_table "best_bowlings", force: :cascade do |t|
    t.integer "player_id"
    t.integer "year"
    t.string "code"
    t.date "date"
    t.integer "inns"
    t.integer "wkts"
    t.integer "runs"
    t.string "opp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_best_bowlings_on_player_id"
  end

  create_table "captains", force: :cascade do |t|
    t.integer "player_id"
    t.string "code"
    t.integer "year"
    t.integer "matches"
    t.integer "won"
    t.integer "lost"
    t.integer "drawn"
    t.integer "nodecision"
    t.integer "tied"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_captains_on_player_id"
  end

  create_table "hundred_plus", force: :cascade do |t|
    t.integer "player_id"
    t.integer "year"
    t.string "code"
    t.date "date"
    t.integer "score"
    t.boolean "notout"
    t.string "opponents"
    t.integer "minutes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_hundred_plus_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "oppo"
    t.string "venue"
    t.string "result"
    t.string "bat_first"
    t.integer "first_runs"
    t.integer "first_wkts"
    t.boolean "first_all_out"
    t.string "first_notes"
    t.integer "second_runs"
    t.integer "second_wkts"
    t.boolean "second_all_out"
    t.string "second_notes"
    t.integer "tocc_w"
    t.integer "tocc_nb"
    t.integer "tocc_b"
    t.integer "tocc_lb"
    t.integer "opp_w"
    t.integer "opp_nb"
    t.integer "opp_b"
    t.integer "opp_lb"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partnerships", force: :cascade do |t|
    t.integer "year"
    t.integer "wicket"
    t.date "date"
    t.integer "total"
    t.boolean "undefeated"
    t.string "bat1"
    t.integer "bat1score"
    t.boolean "bat1notout"
    t.string "bat2"
    t.integer "bat2score"
    t.boolean "bat2notout"
    t.string "opp"
    t.integer "bat1_id"
    t.integer "bat2_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "performances", force: :cascade do |t|
    t.integer "player_id"
    t.string "code"
    t.integer "year"
    t.integer "matches"
    t.integer "innings"
    t.integer "notout"
    t.integer "highest"
    t.boolean "highestnotout"
    t.integer "runsscored"
    t.integer "fours"
    t.integer "sixes"
    t.integer "overs"
    t.integer "balls"
    t.integer "maidens"
    t.integer "wides"
    t.integer "noballs"
    t.integer "runs"
    t.integer "wickets"
    t.integer "fivewktinn"
    t.integer "caught"
    t.integer "stumped"
    t.integer "fifties"
    t.integer "hundreds"
    t.integer "fives"
    t.integer "caughtwkt"
    t.integer "captain"
    t.integer "keptwicket"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_performances_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "code"
    t.string "surname"
    t.string "initial"
    t.string "firstname"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "season_records", force: :cascade do |t|
    t.integer "year"
    t.string "club"
    t.integer "runsscored"
    t.integer "wicketslost"
    t.integer "highest"
    t.integer "highestwkts"
    t.date "highestdate"
    t.string "highestopps"
    t.integer "lowest"
    t.integer "lowestwkts"
    t.date "lowestdate"
    t.string "lowestopps"
    t.integer "byes"
    t.integer "legbyes"
    t.integer "wides"
    t.integer "noballs"
    t.integer "ballsbowled"
    t.integer "ballsreceived"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.integer "played"
    t.integer "won"
    t.integer "lost"
    t.integer "drawn"
    t.integer "tied"
    t.integer "noresult"
    t.integer "maxpossiblegames"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "best_bowlings", "players"
  add_foreign_key "captains", "players"
  add_foreign_key "hundred_plus", "players"
  add_foreign_key "performances", "players"
end
