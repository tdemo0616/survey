FactoryBot.define do
  factory :survey, class: 'Survey' do
    name { Faker::Name.name }
    description { Faker::Address.full_address }
  end
end
  