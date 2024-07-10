require_relative 'lib/app/scrapper'

# Crée une nouvelle instance de la classe Scrapper
scrapper = Scrapper.new

# Demande à l'utilisateur de choisir le format de sauvegarde
puts "Choisissez le format de sauvegarde :"
puts "1. JSON"
puts "2. Google Spreadsheet"
puts "3. CSV"

choice = gets.chomp.to_i

# Sauvegarde les données dans le format choisi par l'utilisateur
case choice
when 1
  scrapper.save_as_json
when 2
  scrapper.save_as_spreadsheet
when 3
  scrapper.save_as_csv
else
  puts "Choix invalide"
end
