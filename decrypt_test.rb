require 'rubygems'
require 'zip'
require 'pry'
require('nkf')

def decrypt(path)
  password = 'test'
  decrypter = Zip::TraditionalDecrypter.new(password)
  entries = []
  Zip::InputStream.open(path, 0, decrypter) do |zip_file|
    while (entry = zip_file.get_next_entry)
      text = zip_file.read
      decrypted = decrypter.decrypt(text)
      entries << entry.name
    end
  end

  puts entries
end

def open_zip(path)
  entries = []
  Zip::File.open(path) do |zip_file|
    zip_file.each do |entry|
      next if entry.name.match(%r[.DS_Store])
      save_path = File.join("#{entry.name}")
      zip_file.extract(entry, save_path) { true }
      entries << save_path
    end
  end
  puts entries
end


path = "./mac.zip"
decrypt(path)

