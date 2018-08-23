require 'faker'
FactoryBot.define do
    factory :post do
      title {Faker::Name.name}
      content {Faker::BojackHorseman.quote}
    end
end