class SeasonRecordController < ApplicationController
  def index
    @season_records = Hash.new{|h, yr| h[yr] = {}}
    SeasonRecord.all.each do |rec|
      @season_records[rec.year][rec.club] = rec
    end
  end
end
