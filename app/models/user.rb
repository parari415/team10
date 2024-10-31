class User < ApplicationRecord
    has_many :recipes
    has_many :likes
  
    validates :uid, presence: true, uniqueness: true
  
    # パスワードをハッシュ化して保存
    def password=(raw_password)
      self.pass = BCrypt::Password.create(raw_password)
    end
  
    # 認証用メソッド
    def authenticate(raw_password)
      BCrypt::Password.new(self.pass) == raw_password
    end
  end