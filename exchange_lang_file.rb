require 'fileutils'
path = "/Users/willy/work/ocm-frontend/application/language/"
target_path = "/Users/willy/work/ocm-frontend/application/language/ocm-frontend-i18n/"

folders = Dir[path + '*'].select{ |f| !File.file? f }

folders.each do |folder_path|

    last_folder = folder_path.rpartition('/').last
    folder_path_files= Dir[folder_path + '/*'].select{ |f| File.file? f }

    folder_path_files.each do |file|

        file_name_with_ext = file.rpartition('/').last
        file_name = file_name_with_ext.split('.').first

        source_path = "#{path}#{last_folder}"
        new_source_path = "#{target_path}#{file_name}"

        source_path_file = "#{source_path}/#{file_name_with_ext}"
        new_source_path_old_file = "#{new_source_path}/#{file_name_with_ext}"
        new_source_path_file = "#{new_source_path}/#{last_folder}.php"

        # create folder
        unless File.directory? new_source_path
            FileUtils.mkdir_p new_source_path
        end

        # cp file to new source path
        unless File.exist? new_source_path_file
            # puts "source_path: #{source_path_file}, new_source_path: #{new_source_path_file}"

            FileUtils.cp source_path_file, new_source_path
            FileUtils.mv new_source_path_old_file, new_source_path_file
        end

    end

end
