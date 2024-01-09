class User < ApplicationRecord
    validates :username, 
        presence: { 
            message: "Логин: обязательное поле" 
        },
        uniqueness: {
            message: "Логин: занято" 
        }, 
        length: { 
            minimum: 4,
            message: "Логин: минимум 4 символа"
        },
        format: { 
            with: /\A[a-zA-Z0-9]+\Z/, 
            message: "Логин: без пробелов" 
        }

    validates :email, 
        presence: { 
            message: "Email: обязательное поле" 
        },
        uniqueness: {
            message: "Email: занято" 
        },
        format: {
            with: URI::MailTo::EMAIL_REGEXP,
            message: "Email: это не email"
        }

    validates :password, 
        presence: { 
            message: "Пароль: обязательное поле" 
        },
        format: {
            with: /\A
                      (?=.{8,})          # Must contain 8 or more characters
                      (?=.*\d)           # Must contain a digit
                      (?=.*[a-z])        # Must contain a lower case character
                      (?=.*[A-Z])        # Must contain an upper case character
                      (?=.*[[:^alnum:]]) # Must contain a symbol
                  /x,
            message: "Пароль: должен содержать 8 или более символов, в том числе: " <<
                     "цифру, " <<
                     "буквы нижнего " <<
                     "и верхнего регистра, " <<
                     "а также спец. символ"
        }

    before_save :downcase_fields

    def downcase_fields
        self.username.downcase!
        self.email.downcase!
    end
end
