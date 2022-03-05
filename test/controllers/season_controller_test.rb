# frozen_string_literal: true

require 'test_helper'

class SeasonControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get season_index_url
    assert_response :success
  end
end
