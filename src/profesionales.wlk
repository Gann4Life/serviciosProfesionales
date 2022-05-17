object asociacionDeProfesionalesDelLitoral {
	var totalRecaudado = 0
	method recibirDonacion(valor) { totalRecaudado += valor }
}

// esta clase está completa, no necesita nada más
class ProfesionalAsociado {
	var universidad
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method provinciasDondePuedeTrabajar() { return #{"Entre Ríos", "Corrientes", "Santa Fe"} }
	
	method honorariosPorHora() { return 3000 }
	
	method cobrar(importe) {
		// Donar todo a la asociación
		asociacionDeProfesionalesDelLitoral.recibirDonacion(importe)
	}
}


// a esta clase le faltan métodos
class ProfesionalVinculado {
	var universidad
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method provinciasDondePuedeTrabajar() = #{ self.universidad().provincia() }
	
	method honorariosPorHora() = self.universidad().honorariosPorHoraRecomendados()
	method cobrar(importe) {
		universidad.recibirDonacion(importe/2)
		// La otra mitad la gasta, no hay porque realizar más acciones.
	}
}


// a esta clase le faltan atributos y métodos
class ProfesionalLibre {
	var universidad
	var honorariosPorHora
	var provinciasDondePuedeTrabajar
	var totalRecaudado = 0
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method honorariosPorHora() = honorariosPorHora
	
	method provinciasDondePuedeTrabajar() = provinciasDondePuedeTrabajar
	
	method cobrar(importe) { totalRecaudado += importe }
	method pasarDinero(profesional, cantidad) { 
		totalRecaudado -= cantidad
		profesional.cobrar(cantidad)
	}
}

class Universidad {
	var provincia
	var honorariosPorHoraRecomendados
	var totalRecaudado = 0
	
	method provincia() = provincia
	method honorariosPorHoraRecomendados() = honorariosPorHoraRecomendados
	method recibirDonacion(valor) { totalRecaudado += valor }
}

class EmpresaDeServicios {
	var profesionalesContratados = #{}
	var honorarioDeReferencia

	method profesionalesContratados() = profesionalesContratados

	method cuantosEstudiaronEn(universidad) = profesionalesContratados.count{profesional => profesional.universidad() == universidad}
	method profesionalesCaros() = profesionalesContratados.filter{profesional => profesional.honorariosPorHora() > honorarioDeReferencia}
	method universidadesFormadoras() = profesionalesContratados.map({profesional => profesional.universidad()}).asSet()
	method profesionalMasBarato() = profesionalesContratados.min{profesional => profesional.honorariosPorHora()}
	
	method esDeGenteAcotada() = !profesionalesContratados.any{profesional => profesional.provinciasDondePuedeTrabajar().size() > 3}
	
	method puedeSatisfacerA(solicitante) = profesionalesContratados.any{profesional => solicitante.puedeSerAtendidoPor(profesional)}
}

class Persona {
	var provincia
	method provincia() = provincia
	method puedeSerAtendidoPor(profesional) = profesional.provinciasDondePuedeTrabajar().any{prov => prov == provincia}
}

