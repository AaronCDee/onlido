require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup 
        @user = users(:aaron)
    end

    test "new should create and redirect to profile" do
        get new_user_path
        assert_response :success
    end
end
