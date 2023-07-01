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
                            length:        { minimum: 6 }

    private 
        def clean_email
            email.strip.downcase # why should I add the bang! in here?
        end
end
