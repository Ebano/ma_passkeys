# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should initiate registration successfully" do
    User.create!(email: "alice")

    post session_url, params: { session: { email: "alice" }, format: :json }

    assert_response :success
  end

  test "should return error if creating session with inexisting email" do
    post session_url, params: { session: { email: "alice" }, format: :json }

    assert_response :unprocessable_entity
    assert_equal ["Email doesn't exist"], JSON.parse(response.body)["errors"]
  end

  test "should return error if creating session with blank email" do
    post session_url, params: { session: { email: "" }, format: :json }

    assert_response :unprocessable_entity
    assert_equal ["Email doesn't exist"], JSON.parse(response.body)["errors"]
  end
end
