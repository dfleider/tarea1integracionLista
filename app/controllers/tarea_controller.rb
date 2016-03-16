class TareaController < ApplicationController
	skip_before_action :verify_authenticity_token
	def status
		head 201
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
