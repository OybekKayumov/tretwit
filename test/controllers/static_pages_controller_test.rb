require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Tretwit App"
  end

  test "should het root" do
    get root_url
    assert_response :success
  end
  
  test "should get home" do
    # get static_pages_home_url
    get root_path
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    # get static_pages_help_url
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    # get static_pages_about_url
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    # get static_pages_contact_url
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end
