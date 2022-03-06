# frozen_string_literal: true

class SeasonController < ApplicationController
  def index
    @seasons = Season.all
  end
end
