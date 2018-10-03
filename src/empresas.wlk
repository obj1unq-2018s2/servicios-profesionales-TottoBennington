import profesionales.*
import universidades.*
class Empresa {
	var property honorarioDeReferencia
	var property profesionalesCaros = []
	var property otrosProfesionales = []
	var provincias = []
	
	method agregarProfesional(profesional){
		if(profesional.honorariosPorHora()>honorarioDeReferencia){
			profesionalesCaros.add(profesional)
		}else{
			otrosProfesionales.add(profesional)
		}
	}
	
	method universidadesFormadoras() {
		var univForm = profesionalesCaros+otrosProfesionales.map{
			prof => prof.universidad()
		}.asList()
		return univForm
	}
	
	method profesionalMasBarato(){
		return otrosProfesionales.find{
			prof => prof.honorariosPorHora().min()
		}
	}
	
	method agregarProvincia(provincia){provincias.add(provincia.toString())}
	
	method estaCubieraProvincia(provincia) = profesionalesCaros+otrosProfesionales.any{
		prof => prof.provinciasDondePuedeTrabajar().contains(provincia)
		
	}
	
	method nroDeProfesionalesFormadosEn(universidad)= profesionalesCaros+otrosProfesionales.filter{
			prof => prof.universidad() == universidad
	}.size()
	
	method esAtractivo(profesional){ // nose si funciona
		profesional.provinciasDondePuedeTrabajar().foreach{
			prov => profesionalesCaros+otrosProfesionales.any{
				prof => prof.honorariosPorHora()<profesional.honorariosPorHora() && profesional.provinciasDondePuedeTrabajar().contains(prov)
			}
		}
	}
}
