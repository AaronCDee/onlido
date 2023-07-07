class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    before_validation :clean_email

    has_secure_password

    validates :name,        presence:      true,
                            length:        { maximum: 50 }

    validates :email,       presence:      true,
                            uniqueness:    true,
                            length:        { maximum: 255 },
                            format:        { with: VALID_EMAIL_REGEX }

    validates :password,    presence:      true, 
                            length:        { minimum: 6 },
                            allow_nil:     true

    def User.digest(str)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        
        BCrypt::Password.create(str, cost: cost)
    end

    private 
        def clean_email
            email.strip.downcase # why should I add the bang! in here?
        end

end
