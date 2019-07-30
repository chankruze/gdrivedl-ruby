$GITHUB_URL = "https://github.com/chankruze/gdrivedl/"
$ISSUES_URL = "https://github.com/chankruze/gdrivedl/issues"
$WEBSITE_URL = "https://rubygems.org/gems/gdrivedl"

class Gdrivedl
  # colors
  def self.red()
    red = "\033[01;31m"
  end
  def self.green()
    green = "\033[01;32m"
  end
  def self.blue()
    blue = "\033[01;34m"
  end
  def self.yellow()
    yellow = "\033[01;33m"
  end
  def self.white()
    white = "\033[01;37m"
  end
  def self.purple()
    purple = "\033[01;35m"
  end

  # banner
  def self.banner()
    puts "\n#{blue}"
    puts " ██████╗ ██████╗ ██████╗ ██╗██╗   ██╗███████╗██████╗ ██╗"
    puts "██╔════╝ ██╔══██╗██╔══██╗██║██║   ██║██╔════╝██╔══██╗██║"
    puts "██║  ███╗██║  ██║██████╔╝██║██║   ██║█████╗  ██║  ██║██║"
    puts "██║   ██║██║  ██║██╔══██╗██║╚██╗ ██╔╝██╔══╝  ██║  ██║██║"
    puts "╚██████╔╝██████╔╝██║  ██║██║ ╚████╔╝ ███████╗██████╔╝███████╗"
    puts " ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝╚═════╝ ╚══════╝"
    puts "#{green}>_ Download Google Drive Files With Wget"
    puts "#{white}=============================================================#{yellow}\n"
    puts "# Version: 0.0.0"
    puts "# Developer: chankruze (Chandan Kumar Mandal)"
    puts "# Company: Geekofia"
    puts "# Website: #$WEBSITE_URL"
    puts "#{white}=============================================================\n"
  end

  # help
  def self.usage()
    puts "\n#{green}Usage: #{white}gdrivedl <FILE_ID> <FILE_NAME>"
    puts "\n#{green}Example: #{white}gdrivedl 1xvhbFWetzTf9a1TueWJBcrzzVPycG1dg gdrivedl_demo.txt"
    puts "#{white}\nThe FILE_NAME argument is the name of the file you want to save as.\nIt can also be a path. For example (/home/user/test/demo.zip)"
    puts "#{white}\nThe FILE_ID argument is the google drive's unique ID for the particular file.\nThis id is the 33 digit alpha numeric and can be found after (?id=) the URL of the file.\nFor example, ID of a file having (https://drive.google.com/open?id=1xvhbFWetzTf9a1TueWJBcrzzVPycG1dg)\nas it's public sharing URL is (1xvhbFWetzTf9a1TueWJBcrzzVPycG1dg) (after ?id=)"
    puts "\nReport bugs/issues at <#$ISSUES_URL>"
  end
  
  # errors
  def self.error(err_code)
    puts "\n"
    case err_code
    when 1
      puts "#{red}Error #{err_code}: Neither file id nor name provided"
    when 2
      puts "#{red}Error #{err_code}: No file id provided"
    when 3
      puts "#{red}Error #{err_code}: No file name provided"
    end
  end

  # main download function
  def self.download(file_id, file_name)
    system "clear"
    banner()

    if file_id == nil && file_name == nil
      error(1)
      usage()
    elsif file_id == nil
      error(2)
      usage()
    elsif file_id != nil && file_name == nil
      error(3)
      usage()
    else
      puts "#{blue}File ID: #{white}#{file_id}"
      puts "#{blue}File Name (to save as): #{white}#{file_name}"
      puts "#{white}\n================= Logs ================="
      @cookies=`(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=#{file_id}" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')`
      system `wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=#@cookies&id=#{file_id}" -O #{file_name}`
      system `rm -rf /tmp/cookies.txt`
      puts "=================================="
      puts "#{green}\nDownloaded file #{file_name} !"
    end
  end
end
