# frozen_string_literal: true

require 'rubyXL'
require 'rubyXL/convenience_methods'

class ExcelAveragesImporter
  def initialize(path)
    @path = path
  end

  def import
    wkbk = RubyXL::Parser.parse(@path)
    matches = wkbk['Matches']
    MatchImporter.new(year_from(@path)).import(matches.sheet_data)
  end

  def year_from(date_string)
    /\d+/.match(date_string)[0]
  end
end

class MatchImporter
  def initialize(year)
    @year = year.to_i
  end

  def import(sheet_data)
    sheet_data.rows.select { |row| match_line?(row) }.each { |row| save_match(row) }
  end

  def save_match(row)
    fields = {}.tap do |h|
      MatchDef.cols.each_value do |col_set|
        col_set.each do |col_index, field_name|
          h[field_name] = row[col_index].value
        end
      end
    end
    convert_field_types fields
    Match.new(fields).save!
  end

  def convert_field_types(fields)
    ColDef.transforms.each do |col_type, transform|
      MatchDef.cols[col_type].each do |col|
        col_name = col.last
        fields[col_name] = transform.call(fields[col_name])
      end
    end
  end

  def match_line?(row)
    row[1].value.is_a? DateTime and row[4].value
  end
end

class ColDef
  class << self
    def transforms
      {
        date_cols: ->(v) { v },
        int_cols: ->(v) { v.to_i },
        bool_cols: ->(v) { v == 'Y' },
        str_cols: ->(v) { v }
      }
    end
  end
end

class MatchDef
  class << self
    def cols
      {
        date_cols: [[1, :date]].to_h,
        int_cols: [
          [6, :first_runs], [7, :first_wkts], [10, :second_runs], [11, :second_wkts], [14, :tocc_w],
          [15, :tocc_nb], [16, :tocc_b], [17, :tocc_lb], [18, :opp_w], [19, :opp_nb], [20, :opp_b], [21, :opp_lb]
        ].to_h,
        bool_cols: [[8, :first_all_out], [12, :second_all_out]].to_h,
        str_cols: [[2, :oppo], [3, :venue], [4, :result], [5, :bat_first], [9, :first_notes], [13, :second_notes]].to_h
      }
    end
  end
end
