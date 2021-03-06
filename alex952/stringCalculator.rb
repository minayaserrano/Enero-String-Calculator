class StringCalculator

	def Add(param)
		#It's a blank line of parameters
		return 0 if param == "" 

		separator = getRegexpSeparator(param)
		error = Array.new

		#Split the parameters from a separator
		params = param.split(separator)
		res = 0

		#Add the parts, the operands
		params.each do |p|
			begin
				num = Integer(p)

				if num < 0 then
					error.push num
				elsif p.length < 3 then
					res += num
				end
			rescue
			end
		end

		if error.length == 0 then
			return res
		else 
			ex = 'negatives not allowed - '

			error.each do |er|
				ex += er.to_s() + ' '
			end

			raise ex
		end
	end

	def getRegexpSeparator(str)
		#Searching for a separator field within param string
		sep_fetch = str.split("\n")

		separator = ""

		if sep_fetch.length > 1 && sep_fetch[0] =~ /^\/\/(\[.\])+/ then 
			separator = sep_fetch[2..-1]
			separator = separator.gsub(/\[/, "")
			separator = separator.gsub(/\]$/, "")
			separator = separator.gsub(/\]/, "|")
		elsif sep_fetch.length > 1 && sep_fetch[0] =~ /^\/\/./ then
			#Exists the separator within params string
			separator = sep_fetch[0][2..-1]
		else 
			#Search for separator
			str.each_char do |c|
				begin
					Integer(c)
				rescue
					if c != '-' then
						separator = c
						break
					end
				end
			end
		end

		return Regexp.compile("[" + Regexp.escape(separator.to_s()) + "]") if separator != ""

		return separator
	end
end
