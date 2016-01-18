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

ActiveRecord::Schema.define(version: 20160117172110) do

  create_table "anunciante_contratos", force: :cascade do |t|
    t.integer  "anunciante_id", precision: 38
    t.float    "importe"
    t.datetime "fecha"
    t.string   "descripcion"
    t.datetime "duracion"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "anunciante_contratos", ["anunciante_id"], name: "i_anu_con_anu_id"

  create_table "anunciantes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "web"
    t.string   "fiscales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anuncio_allocations", force: :cascade do |t|
    t.integer  "anuncio_id", precision: 38
    t.integer  "espacio_id", precision: 38
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "anuncio_allocations", ["anuncio_id"], name: "i_anu_all_anu_id"
  add_index "anuncio_allocations", ["espacio_id"], name: "i_anu_all_esp_id"

  create_table "anuncios", force: :cascade do |t|
    t.integer  "anunciante_id", precision: 38
    t.text     "contenido"
    t.string   "url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "anuncios", ["anunciante_id"], name: "i_anuncios_anunciante_id"

  create_table "audiences", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cobros", force: :cascade do |t|
    t.float    "importe"
    t.datetime "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "espacios", force: :cascade do |t|
    t.integer  "medio_id",               precision: 38
    t.boolean  "multimedia", limit: nil
    t.boolean  "enlace",     limit: nil
    t.integer  "ancho",                  precision: 38
    t.integer  "alto",                   precision: 38
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "espacios", ["medio_id"], name: "index_espacios_on_medio_id"

  create_table "medio_contratos", force: :cascade do |t|
    t.integer  "medio_id",    precision: 38
    t.float    "importe"
    t.datetime "fecha"
    t.string   "descripcion"
    t.datetime "duracion"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "medio_contratos", ["medio_id"], name: "i_medio_contratos_medio_id"

  create_table "medios", force: :cascade do |t|
    t.string   "nombre"
    t.string   "web"
    t.string   "fiscales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pagos", force: :cascade do |t|
    t.float    "importe"
    t.datetime "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "anunciante_contratos", "anunciantes"
  add_foreign_key "anuncio_allocations", "anuncios"
  add_foreign_key "anuncio_allocations", "espacios"
  add_foreign_key "anuncios", "anunciantes"
  add_foreign_key "espacios", "medios"
  add_foreign_key "medio_contratos", "medios"
end
