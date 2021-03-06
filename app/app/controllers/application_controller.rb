class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def delete_records
    [Anunciante, Anuncio, AnuncioAllocation, AnuncianteContrato, Cobro,
    Medio, Espacio, MedioContrato, Pago, Audience].map &:destroy_all
  end

  public
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
  end

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    redirect_to controller: :errors, action: :error404, status: 404
  end

  def render_not_found e
    respond_to do |f|
      f.html { render template: "errors/error404", status: 404 }
    end
  end

  # Acciones de 'Opciones avanzadas' en la página de inicio
  def delete_all
    delete_records
    redirect_to :root
  end

  def reset_data
    delete_records

    anunciantes = [
      {nombre: "SEGA", web: "http://sega.com", fiscales: 536400000},
      {nombre: "Nintendo", web: "http://nintendo.com", fiscales: 212732400},
      {nombre: "Sony", web: "http://sony.es", fiscales: 502700000},
      {nombre: "Anaya Multimedia", web: "http://anayamultimedia.es", fiscales: 424140000},
      {nombre: "Tesla Motors", web: "http://teslamotors.com", fiscales: 735140000},
      {nombre: "Toyota", web: "http://toyota.com", fiscales: 701074000},
      {nombre: "DAW Books", web: "http://dawbooks.com", fiscales: 43800650},
      {nombre: "Ediciones B", web: "http://edicionesb.es", fiscales: 3015102358},
      {nombre: "Nuclear Blast Records", web: "http://nuclearblast.de", fiscales: 205134000},
      {nombre: "Spinnin Records", web: "http://spinninrecords.com", fiscales: 591221200}
    ]
    medios = [
      {nombre: "Polygon", web: "http://polygon.com", fiscales: 901160200},
      {nombre: "The Verge", web: "http://theverge.com", fiscales: 783738630},
      {nombre: "MotorAdictos", web: "http://www.motoradictos.com", fiscales: 123456000},
      {nombre: "Fantífica", web: "http://fantifica.com", fiscales: 542715100},
      {nombre: "Spotify", web: "http://spotify.com", fiscales: 590715100}
    ]
    audiencias = [
      {nombre: "Gamers", descripcion: "Gamers"},
      {nombre: "Geeks", descripcion: "Geeks"},
      {nombre: "Conductores", descripcion: "Conductores"},
      {nombre: "Lectores", descripcion: "Lectores"},
      {nombre: "Jóvenes", descripcion: "Jóvenes"},
      {nombre: "Niños", descripcion: "Niños"},
      {nombre: "Adultos", descripcion: "Adultos"}
    ]

    anunciantes.each { |params| Anunciante.create params }
    medios.each { |params| Medio.create params }
    audiencias.each { |params| Audience.create params }

    Anunciante.find_each.each_with_index { |a,i| a.audiences << Audience.find(i / 2 + Audience.take.id) }
    Medio.find_each.each_with_index { |m,i| m.audiences << Audience.find(i + Audience.take.id) }

    anunciante_uno = Anunciante.take
    anunciante_dos = Anunciante.take(2)[1]

    anun_uno = anunciante_uno.anuncios.create! contenido: "Sonic The Hedgehog 2016", url: ""
    anun_dos = anunciante_dos.anuncios.create! contenido: "Super Smash Bros 3Ds", url: "http://www.smashbros.com"
    cont_uno = anunciante_uno.anunciante_contratos.create! descripcion: "Anunciar Sonic '16", fecha: 2.days.ago, duracion: 2.years.from_now, importe: 10000
    cont_dos = anunciante_dos.anunciante_contratos.create! descripcion: "Anunciar Smash Bros", fecha: 2.days.ago, duracion: 2.years.from_now, importe: 6280
    cont_uno.cobros.create! importe: 250, fecha: 1.day.ago
    cont_uno.cobros.create! importe: 360, fecha: 1.day.ago
    cont_dos.cobros.create! importe: 222, fecha: 1.day.ago
    cont_dos.cobros.create! importe: 100, fecha: 1.day.ago

    medio_uno = Medio.take

    medio_uno.espacios.create! ancho: 256, alto: 512, multimedia: true, enlace: false
    medio_uno.espacios.create! ancho: 256, alto: 512, multimedia: true, enlace: true
    medio_uno.espacios.create! ancho: 1024, alto: 512, multimedia: false, enlace: false
    medio_uno.espacios.create! ancho: 512, alto: 512, multimedia: true, enlace: true
    cont_tres = medio_uno.medio_contratos.create! descripcion: "Anunciar videojuegos", fecha: 2.days.ago, duracion: 2.years.from_now, importe: 12000
    cont_tres.pagos.create! importe: 1000, fecha: 1.day.ago

    anun_uno.espacios << Espacio.take
    anun_dos.espacios << Espacio.take(2)[1]

    redirect_to :root
  end
end
