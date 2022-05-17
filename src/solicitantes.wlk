import profesionales.*

class Persona {
	var provincia
	method provincia() = provincia
	method puedeSerAtendidoPor(profesional) = profesional.provinciasDondePuedeTrabajar().contains(provincia)
}
