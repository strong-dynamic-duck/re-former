class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless URI::MailTo::EMAIL_REGEXP.match?(value)
            record.errors.add attribute, (options[:message] || "is not an email")
        end
    end
end

PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

class PasswordValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless PASSWORD_FORMAT.match?(value)
            record.errors.add attribute, (
                options[:message] ||
                "Must contain 8 or more characters, " <<
                "a digit, " <<
                "a lower case character, " <<
                "an upper case character " <<
                "and a symbol"
            )
        end
    end
end

class User < ApplicationRecord
    validates :username, 
        presence: true, 
        uniqueness: true, 
        length: { minimum: 4 }

    validates :email, 
        presence: true, 
        uniqueness: true, 
        email: true

    validates :password, 
        presence: true,
        password: true

    before_save :downcase_fields

    def downcase_fields
        self.username.downcase!
        self.email.downcase!
    end
end
