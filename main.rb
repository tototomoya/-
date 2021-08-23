# 営業時間は9時～21時（1,2,3は9時、10時、12時を表す）
# 同じ時間帯は二人まで。
# 一週間ごと

# https://ruby-doc.org/
# https://replit.com/@hitabacokyou/sihutoBiao#main.rb

require "json"

class Sihuto
	# @@sihuto = {youbi=>[StaffName,1,2,3,4] }
	@@sihuto = {}
	
	@@StaffID = {
		"0123"=>"test", "1234"=>"test2", "0122"=>"test3", "1236"=>"test4"
	}
	@@BlankID = ["0234", "4322", "0236", "0239"]

	# シフト表の作成	
	def sihuto(name, youbi, sihuto)
		if not checkID(name)
			@@StaffID[@@BlankID.pop] = name
		end
		sihuto.unshift(@@StaffID.key(name))
		if @@sihuto.key?(youbi) 
			if check(youbi, sihuto)
				@@sihuto[youbi] += sihuto
				return true
			end 
			return false
		end
		@@sihuto[youbi] = sihuto
		return true
	end

		# 同じ時間帯に入るスタッフの人数の確認
		def check(youbi, sihuto)
			for time in sihuto
				if @@sihuto[youbi].count(time) >= 2
					return false
				end
			end
			return true
		end

		# スタッフIDの確認
		def checkID(name)
			if not @@StaffID.value?(name)
				return false
			end
			return true
		end

	def printSihuto()
		File.write(
			'./public/sample.json', JSON.dump(@@sihuto)
		)
	end

	def printStaffID() 
		File.write(
			'./public/StaffID.json', JSON.dump(@@StaffID)
		)
	end
end
	

class Staff

	# スタッフ一人一人に渡すシフト表
	# @sihutohyou 
	# @hairenakattahi

	def initialize(name)
		@name = name
		@sihutohyou = {}
		@hairenakattahi = {}
	end

	def sihuto(youbi, sihuto)
		if $sihuto.sihuto(@name, youbi, sihuto) 
			@sihutohyou[youbi] = sihuto
			return
		end
		@hairenakattahi[youbi] = sihuto
	end

	def printSihutohyou()
		if not @sihutohyou == {}
			puts "#@name #@sihutohyou でお願いします。"
		end
	end

	def printHairenakattahi()
		if not @hairenakattahi == {}
			puts "#@name #@hairenakattahi は入れません。"
		end
	end

end

$sihuto = Sihuto.new()

time = [1,2,3,4,5,6,7,8,9,10,11,12]
youbi = "月火水木金土日"

staffa = Staff.new("test5") 
staffb = Staff.new("test6") 
staffc = Staff.new("test3") 
staffd = Staff.new("test4") 
staffe = Staff.new("test7") 
staffg = Staff.new("test8") 
staffh = Staff.new("test9") 

staffa.sihuto(youbi[0], time[0..8])
staffb.sihuto(youbi[1], time[3..5])
staffc.sihuto(youbi[2], time[3..5])
staffd.sihuto(youbi[3], time[3..5])
staffe.sihuto(youbi[4], time[3..5])
staffh.sihuto(youbi[0], time[0..7])

$sihuto.printSihuto()
$sihuto.printStaffID()

# cssファイルの作成
class Util_CSS < Sihuto	
	@@file = File.new("./public/index.css", "a")
	@@name = []
	Color = ["maroon","red","purple","fuchsia","green","lime","olive","yellow","navy","blue","teal","aqua"]
	
	def start()
		i = 0
		for key, value in @@StaffID
			createCSS(value, Color[i])
			i = i + 1
		end
		@@file.close
	end

	def createCSS(name, color)
		if not @@name.include?(name)
			@@file.puts("##{name}{fill:#{color};}")
			@@name.push(name)
		end
		return
	end
end
css = Util_CSS.new()
css.start()