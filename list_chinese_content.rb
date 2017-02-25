# 找尋檔案中有中文字的
site = "SITE#{ARGV[0]}"
file_name = ARGV[1] #'js/scriptM.js'
file_path = "PATH#{site}/html/#{file_name}"

unless File.exist? file_path
    puts "file: '#{file_path}' not exist."
    exit
end

File.open(file_path).each_with_index do |line, index|
    # 找尋 code 裡面含有中文的，排除註解中文的
    hans = line.scan(/^(?!.*\/\/).*\p{Han}.*$/)

    if hans.count != 0
        puts "line: #{index+1}, content: #{line}"
    end
end
