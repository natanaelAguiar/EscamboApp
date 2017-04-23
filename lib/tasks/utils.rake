namespace :utils do
  desc "Generate Faker Admins"
  task generate_admins: :environment do
    puts 'Gerando os ADMINISTRADORES...'
    10.times do
        Admin.create!(email: Faker::Internet.email,
                      password: "123123",
                      password_confirmation: "123123")
    end
    puts 'ADMINISTRADORES cadastrados com sucesso'
  end

end
