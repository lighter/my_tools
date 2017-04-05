def get_files(folder_name)
    if (File.directory? folder_name)
        equal = '='
        puts "#{equal * 20} #{folder_name} #{equal * 20}"
        return Dir[folder_name + '/*']
    end
end

def open_file_list_chinese(files)
    files.each do |file|
        if (File.file? file)
            file_lines = []

            File.open(file).each_with_index do |line, index|
                # 找尋 code 裡面含有中文的，排除註解中文的
                hans = line.scan(/^(?!.*\<\!).*\p{Han}.*$/)

                if hans.count != 0
                    file_lines.push(index)
                end
            end

            unless file_lines.empty?
                puts "file: #{file}, lines: #{file_lines.join(',')}"
            end
        else
            files = get_files(file)
            open_file_list_chinese(files)
        end
    end
end

# 找尋檔案中有中文字的
for i in 113..113
    site = "SITE#{i}"
    path = "PATH";

    # files = Dir[path + '*'].select{ |f| File.file? f }
    files = Dir[path + '*']

    open_file_list_chinese(files)
end
