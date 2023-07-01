require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@email.test", password: "123456", password_confirmation: "123456")
  end

  test "setup user valid" do
    assert @user.valid?
  end

  test "empty email invalid" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "empty password invalid" do
    @user.password = @user.password_confirmation = ''
    assert_not @user.valid?
  end

  test "password less than 6 characters invalid" do
    @user.password = "12345"
    assert_not @user.valid?
  end

  test "duplicate emails invalid" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "non-matching password and confirmation invlaid" do
    @user.password_confirmation = "123465"
    assert_not @user.valid?
  end

  test "name should be less than 50 chars" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be less than or equal to 255 chars" do
    @user.email = "a" * 256 + "@test.com"
    assert_not @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

end
