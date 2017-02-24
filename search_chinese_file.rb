# 找尋檔案中有中文字的
for i in 104..113
    site = "SITE#{i}"
    path = "PATH#{site}/html/js/*";

    files = Dir[path + '*'].select{ |f| File.file? f }

    files.each do |file|

        file_lines = []

        File.open(file).each_with_index do |line, index|
            # 找尋 code 裡面含有中文的，排除註解中文的
            hans = line.scan(/^(?!.*\/\/).*\p{Han}.*$/)

            if hans.count != 0
                file_lines.push(index)
            end
        end

        unless file_lines.empty?
            puts "file: #{file}, lines: #{file_lines.join(',')}"
        end

    end
end
