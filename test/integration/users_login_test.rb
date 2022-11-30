require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, 
                                          password: "invalid"}}
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email: @user.email, password: 'password' }}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user) 
    delete logout_path
    assert_response :see_other
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "valid signup information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                           email: "user@example.com",
                           password: "password",
                            password_confirmation: "password" }} 
      end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "should still work after logout in second window" do
    delete logout_path
    assert_redirected_to root_url
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end

  test "login without remembering" do 
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted. 
    log_in_as(@user, remember_me: '0')
    # assert cookies[:remember_token].blank?    
  end
end