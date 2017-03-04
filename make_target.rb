#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'json'
require 'csv'

TYPE_FILE="type.json"
DICTIONARY_FILE="dictionary.json"
OUTPUT_FILE="target.csv"

types = {}

File.open(TYPE_FILE) do |file|
  json = JSON.load(file)
  json["array"]["dict"].each do |dict|
    types[dict["string"][3]] = dict["string"][2]
  end
end

CSV.open(OUTPUT_FILE, 'w') do |csv|
  File.open(DICTIONARY_FILE) do |file|
    json = JSON.load(file)
    first_line = true

    json["array"]["dict"].each do |dict|
      if first_line
        first_line = false
        next
      end
      strings =  dict["string"]
      type = types[strings[5]]
      furigana = strings[2][0].tr('ア-ン','あ-ん')
      csv << [type, strings[3], strings[0], furigana]
    end
  end
end
