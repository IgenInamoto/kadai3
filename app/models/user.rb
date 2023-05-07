class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
        has_many :books, dependent: :destroy
        has_many :favorites, dependent: :destroy
        has_many :book_comments, dependent: :destroy
        
        # フォローをした、されたの関係
        has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
        # has_manyの部分はrelationshipsモデルの記載と同じ考え方。class_name: "Relationship"でRelationshipテーブルを参照する。
        # foreign_key(外侮キー)で参照するカラムを指定している。
        
        # 一覧画面で使用する部分
        has_many :following_user, through: :follower, source: :followed
        has_many :follower_user, through: :followed, source: :follower
        # user.followersという記述でフォロワーを表示したいので、throughでスルーするテーブル、sourceで参照するカラムを指定。
        
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_one_attached :profile_image
         
        validates :name,  uniqueness: true, length: { in: 2..20 } 
        
        validates :introduction, length: { maximum: 50 }
      
         
        def get_profile_image(width,height)
          unless profile_image.attached?
            file_path = Rails.root.join('app/assets/images/default-image.jpg')
            profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
          end
            profile_image.variant(resize_to_limit: [width, height]).processed
        end
         
        #  フォローした時の処理
        def follow(user_id)
            follower.create(followed_id: user_id)
        end
         
        # フォローを外す時の処理 
        def unfollow(user_id)
            follower.find_by(followed_id: user_id).destroy
        end
        
        # フォローしているかの判定(フォローしていればtrueを)
        def following?(user)
            following_user.include?(user)
        end
         
         
end
