class TareaController < ApplicationController
	skip_before_action :verify_authenticity_token
	require 'open-uri'
	def status
		head 201
	end

	def texto

	#IO.copy_stream(open('https://s3.amazonaws.com/files.principal/texto.txt','destination.txt'))

	#file = File.open("destination.txt", "rb")
	#contents = file.read


	url = "https://s3.amazonaws.com/files.principal/texto.txt"
	local_fname = "local.txt"
	Encoding.default_external = Encoding.list[1]
	File.open(local_fname, "wb"){|file| file.write(open(url).read)}

	File.open(local_fname, "rb") do |file|
    file.readlines.each_with_index do |line, idx|
    puts line if idx % 42 == 41

	file = File.open(local_fname, "rb")
	@contents = file.read

	#somefile = File.open("sample.txt", "w")
	#somefile.puts contents
	#somefile.close
	


   end   
end
	puts @contents
	digest = Digest::SHA256.hexdigest(@contents)

	puts "digest"
	puts digest

	render json: {contents: @contents.to_s.force_encoding("UTF-8"), Hash: digest}

	end

	def validar
		unless params[:hash] and params[:mensaje]
			head 400
			return
		end

		@mensaje = params[:mensaje]
		digest = Digest::SHA256.hexdigest(@mensaje)
		hash = params[:hash].downcase

		if digest == hash
			render json: {mensaje: @mensaje, valido: true}
		elsif (digest != hash) #&& hash.empty?)
			render json: {valido: false}
		else 
			head 400
		end
	end

end
