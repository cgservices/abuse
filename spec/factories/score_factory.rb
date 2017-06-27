FactoryGirl.define do
  factory :score, class: ::Abuse::Score do
    ip '1.1.1.1'
    points 20
    reason 'login failed'
  end
end
