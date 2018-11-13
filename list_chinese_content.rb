# 找尋檔案中有中文字的
@base_lang_file = ['/Users/willy/work/ocm-frontend/application/language/ocm-frontend-i18n/common_lang/zh-Hans.php',
                  '/Users/willy/work/ocm-frontend/application/language/ocm-frontend-i18n/gamelist_lang/zh-Hans.php',
                  '/Users/willy/work/ocm-frontend/application/language/ocm-frontend-i18n/result_code_lang/zh-Hans.php']

site = "ocm-site-#{ARGV[0]}"
file_name = ARGV[1] #'js/scriptM.js'
file_path = "/Users/willy/work/ocm-frontend/#{site}/#{file_name}"

def try_to_find_php_lang_key(word)
    finded = false
    @base_lang_file.each do |lang_file|

        File.open(lang_file).each_with_index do |line, index|
            regx = /\/\* #{word} \*\//
            match = line.scan(regx)
            #match = regx.match(line)

            if match.count != 0
                finded = true

                return "LANG line: #{index+1}, content: #{line.strip}, component: #{lang_file.split('/')[-2]}"
           end

            break if finded
        end

        break if finded
    end

    return ''
end

unless File.exist? file_path
    puts "file: '#{file_path}' not exist."
    exit
end

File.open(file_path).each_with_index do |line, index|
    # 找尋 code 裡面含有中文的，排除註解中文的
    hans = line.scan(/^(?!.*\<\!).*\p{Han}.*$/)

    if hans.count != 0

        # 排除 // 和 /*-
        if line.match(/\/\//).nil? and line.match(/\/\*\-/).nil?
            match_word = line.match(/\p{Han}+/)
            finded_lang_key = try_to_find_php_lang_key(match_word)

            puts "CAN NOT FIND" if finded_lang_key.empty?
            puts finded_lang_key unless finded_lang_key.empty?
            puts "line: #{index+1}, content: #{line.strip}, match word: #{match_word}"

            puts "-" * 100
        end
    end
end
