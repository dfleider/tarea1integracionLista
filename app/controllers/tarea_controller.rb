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
		hash = params[:hash]

		if digest == hash
			render json: {mensaje: @mensaje, valido: true}
		else 
			head 400
		end
	end

end
