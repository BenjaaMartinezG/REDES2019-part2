require 'httparty'

# Menú inicial
puts ("Cliente de servicio REST \n 1) Validacion de digito verificador RUT \n 2) Saludo nombre propio \n 0)Salir")

opcion = gets.chomp.to_i

# Un bucle para asegurarse que siempre consulte una opción a menos que el usuario decida salir
while opcion != 0
    case opcion 
    when 1
        puts "Ingrese rut sin puntos(1111111-0): "
        rutIngresado = gets.chomp

        urlRut = "http://localhost:5000/rut/#{rutIngresado}"
        response = HTTParty.get(urlRut)
        puts response.body
    when 2
        puts "Nombre: "
        nombres = gets.chomp
        puts "Apellido paterno: "
        apellidoPaterno = gets.chomp
        puts "Apellido materno: "
        apellidoMaterno = gets.chomp
        puts "Genero (M/F):"
        genero = gets.chomp

        until ['F', 'f', 'M', 'm'].include? genero do
            puts "Ingrese una opcion valida (M/F):"
            genero = gets.chomp
        end
        
        data = HTTParty.post( "http://localhost:5000/nombrePropio", body:{
            nombres: nombres,
            aPaterno: apellidoPaterno,
            aMaterno: apellidoMaterno,
            genero: genero
        })
        puts data         
    when 0
        break;
    end
    puts ("\n 1) Validacion de digito verificador RUT \n 2) Saludo nombre propio \n 0)Salir")
    opcion = gets.chomp.to_i
end