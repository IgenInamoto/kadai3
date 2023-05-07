class Relationship < ApplicationRecord
    # class_name: "User"でUserモデルを参照する
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    
    # belongs_to :userとするとどっちがどっちのユーザーかの判別がつかなくなるのでfollowerとfollowedで分けている。
    #このままだと、followerテーブルとfollowedテーブルを探しに行ってしまうため、class_name: "User"でuserテーブルからデータをとってきてもらうようにする。
    
end
