// esta clase está completa, no necesita nada más
class ProfesionalAsociado {
	var universidad
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method provinciasDondePuedeTrabajar() { return #{"Entre Ríos", "Corrientes", "Santa Fe"} }
	
	method honorariosPorHora() { return 3000 }
}


// a esta clase le faltan métodos
class ProfesionalVinculado {
	var universidad
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method provinciasDondePuedeTrabajar() = #{ self.universidad().provincia() }
	
	method honorariosPorHora() = self.universidad().honorariosPorHoraRecomendados()
}


// a esta clase le faltan atributos y métodos
class ProfesionalLibre {
	var universidad
	var honorariosPorHora
	var provinciasDondePuedeTrabajar
	
	method universidad() { return universidad }
	method universidad(univ) { universidad = univ }
	
	method honorariosPorHora() = honorariosPorHora
	
	method provinciasDondePuedeTrabajar() = provinciasDondePuedeTrabajar
}

class Universidad {
	var provincia
	var honorariosPorHoraRecomendados
	
	method provincia() = provincia
	method honorariosPorHoraRecomendados() = honorariosPorHoraRecomendados
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

