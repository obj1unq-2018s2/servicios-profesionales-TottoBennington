import profesionales.*
import universidades.*
class Empresa {
	var property honorarioDeReferencia
	var profesionales = []
	
	method contratarProfesional(profesional){profesionales.add(profesional)}
	
	method profesionalesCaros() = profesionales.filter{
		pro => pro.honorariosPorHora()> self.honorarioDeReferencia()
	}
	
	method universidadesFormadoras() = profesionales.map{
		pro => pro.universidad()
	}.asList().withoutDuplicates().asSet()
	
	method profesionalMasBarato() = profesionales.min{
		pro => pro.honorariosPorHora()
	}
	
	method estaCubierta(provincia) = profesionales.any{
		pro => pro.provinciasDondePuedeTrabajar().contains(provincia)
	}
	
	method profesionalesFormadosEn(unaUniversidad) = profesionales.filter{
		pro => pro.universidad() == unaUniversidad
	}.size()
	
	method esAtractivo(profesional){ // nose si funciona
		profesional.provinciasDondePuedeTrabajar().foreach{
			prov => profesionales.any{
				prof => prof.honorariosPorHora()<profesional.honorariosPorHora() && profesional.provinciasDondePuedeTrabajar().contains(prov)
			}
		}
	}
}
