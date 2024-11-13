def count_files_and_dirs(path)
  file_count = 0
  dir_count = 0

  Dir.foreach(path) do |item|
    next if item == '.' || item == '..'

    full_path = File.join(path, item)
    if File.directory?(full_path)
      dir_count += 1
      sub_file_count, sub_dir_count = count_files_and_dirs(full_path)
      file_count += sub_file_count
      dir_count += sub_dir_count
    else
      file_count += 1
    end
  end

  [file_count, dir_count]
end

puts "Введіть шлях до директорії:"
directory_path = gets.chomp

if Dir.exist?(directory_path)
  file_count, dir_count = count_files_and_dirs(directory_path)
  puts "Кількість файлів: #{file_count}"
  puts "Кількість папок: #{dir_count}"
else
  puts "Директорія не існує!"
end
