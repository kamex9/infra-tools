#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# ==============================================
# 実行前準備
# ==============================================
# 指定オプション保持配列
options = []
# オプション解析設定
opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ruby wc.rb [options] [file]'

  # 行数カウントオプション
  opts.on('-l', '--lines', 'print the newline counts') do
    options.push(:lines)
  end

  # 単語数カウントオプション
  opts.on('-w', '--words', 'print the word counts') do
    options.push(:words)
  end

  # バイト数カウントオプション
  opts.on('-c', '--bytes', 'print the byte counts') do
    options.push(:bytes)
  end
end
# オプション解析設定を元にコマンドライン引数をパース
opt_parser.parse!

# ファイル名取得
filename = ARGV[0]
selfname = $PROGRAM_NAME

### デバッグ用 ###
# p "options=#{options}"
# p "filename=#{filename}"
# p "selfname=#{selfname}"

# 対象ファイル名が不正の場合
if filename.nil?
  puts "#{selfname}: Please specify a file"
  exit 1
end
unless File.exist?(filename)
  puts "#{selfname}: #{filename}: No such file or directory"
  exit 1
end

# ==============================================
# 処理実行
# ==============================================
# オプション無しの場合のデフォルト
options.push :lines, :words, :bytes if options.empty?

# 処理結果格納用ハッシュ
r = { lines: '', words: '', bytes: '' }

# オプションに対応する処理実行
f = File.read(filename)
options.each do |opt|
  r[:lines] = "#{f.lines.length} " if opt == :lines
  r[:words] = "#{f.scan(/\b\w+\b/).uniq.length} " if opt == :words
  r[:bytes] = "#{f.bytesize} " if opt == :bytes
end

# 結果出力
puts "#{r[:lines]}#{r[:words]}#{r[:bytes]}#{filename}"
