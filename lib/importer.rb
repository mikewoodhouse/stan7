# frozen_string_literal: true

require 'csv'

class Importer
  CSV_PATH = "#{Rails.public_path}/csvdata"

  def initialize(klass, opts = {})
    @klass = klass
    @input_filename = opts[:input_filename]
    @string_cols = opts[:string_cols] || []
    @bool_cols = opts[:bool_cols] || []
    @date_cols = opts[:date_cols] || []
    @player_id_col_map = opts[:col_map] || {}
  end

  def fixup_types(h, cols, transform)
    return unless cols

    cols.each do |col|
      h[col] = transform.call(h[col])
    end
  end

  def csv_filepath
    basename = @input_filename || @klass.to_s
    file_name = "#{basename}.txt"
    File.join(CSV_PATH, file_name)
  end

  def players_loaded?
    @players_loaded ||= Player.count.positive?
  end

  def import
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @klass.destroy_all
    player_id_lookup = Hash[Player.all.map { |p| [p.code, p.id] }] if players_loaded?
    File.open(csv_filepath, 'r') do |fin|
      hdrs = CSV.parse(fin.readline).flatten.map(&:downcase)
      int_cols = hdrs - @string_cols - @bool_cols - @date_cols
      until fin.eof
        line = fin.readline
        vals = CSV.parse(line).flatten
        value_hash = Hash[hdrs.zip(vals)]
        fixup_types value_hash, @string_cols, ->(v) { v }
        fixup_types value_hash, @bool_cols, ->(v) { v.to_i == 1 }
        fixup_types value_hash, @date_cols, ->(v) { v ? Date.parse(v) : v }
        fixup_types value_hash, int_cols, ->(v) { v.to_i }
        @klass.new(value_hash) do |obj|
          if players_loaded?
            @player_id_col_map.each do |in_col, out_col|
              obj[out_col] = player_id_lookup[obj[in_col]]
            end
          end
          obj.save!
        end
      end
    end
    ended = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "#{@klass.count} records loaded for #{@klass} in #{(ended - started).round(2)} secs"
  end
end
