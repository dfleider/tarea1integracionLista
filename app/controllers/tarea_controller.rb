class TareaController < ApplicationController
	skip_before_action :verify_authenticity_token
	def status
		head 201
	end

	def validar
		@mensaje = params[:mensaje]
		sha256 = Digest::SHA256.new
		digest = sha256.digest @mensaje

		if digest == params[:hash]
			render json: {mensaje: @mensaje, valido: true}
		else 
			head 400
		end
	end

end
