FactoryBot.define do
  factory :record, class: 'Record' do
    Label { Faker::Name.name }
  end
end
  