require 'json'
require 'google/apis/sheets_v4'
require 'csv'

class Scrapper
  def initialize
    @emails = {"ABLEIGES"=>"mairie.ableiges95@wanadoo.fr", "AINCOURT"=>"mairie.aincourt@wanadoo.fr"} # Hash contenant les emails
  end

  def save_as_json
    # Ouvre un fichier en écriture
    File.open('db/emails.json', 'w') do |f|
      # Écrit le hash @emails dans le fichier au format JSON
      f.write(JSON.pretty_generate(@emails))
    end
  end

  def save_as_spreadsheet
    # Crée une nouvelle feuille Google Spreadsheet
    sheets = Google::Apis::SheetsV4::SheetsService.new
    spreadsheet = sheets.create_spreadsheet('Emails')
    spreadsheet_id = spreadsheet.spreadsheet_id

    # Ajoute les données du hash @emails à la feuille
    range = 'A1:B2' # Plage de cellules où les données seront ajoutées
    values = [['City', 'Email']] + @emails.to_a # Tableau contenant les données à ajouter
    value_range_body = Google::Apis::SheetsV4::ValueRange.new(values: values)
    sheets.update_spreadsheet_value(spreadsheet_id, range, value_range_body, value_input_option: 'RAW')
  end

  def save_as_csv
    # Ouvre un fichier en écriture
    CSV.open('db/emails.csv', 'w') do |csv|
      # Ajoute les en-têtes au fichier CSV
      csv << ["City", "Email"]
      # Ajoute les données du hash @emails au fichier CSV
      @emails.each do |city, email|
        csv << [city, email]
      end
    end
  end
end
