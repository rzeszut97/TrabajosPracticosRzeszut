object springfield {
	var vientos = 10
	var tierra = 0.9
	var necesidad = 20000000
	var centrales = [centralBurns, centralExBosque, centralElSuspiro]
	
	method vientos(){
		return vientos
	}
	method tierra() {
		return tierra
	}
	method necesidad() {
		return necesidad
	} 
	method centrales() {
		return centrales
	}
	method contaminantes(){
		return centrales.filter ({central => central.contaminacion()})
	}
	method produccionTotal(listaCentrales){
		return listaCentrales.sum ({central => central.produccion(self)})
	}
	method estaAlHorno(){
		return (self.contaminaDemasiado()) or self.todasContaminan() 
	}
	method todasContaminan(){
		return centrales.all({central => central.contaminacion()})
	}
	method aporteContaminantes(){
		return self.produccionTotal(self.contaminantes())
	}
	method contaminaDemasiado() {
		return self.aporteContaminantes()>(0.5*self.necesidad())
	}
	method laMejor(){
		return centrales.max({central => central.produccion(self)}) 
	}
	
}

object centralBurns {
	var uranio = 10
	
	method produccion(ciudad) {
		return 0.1*uranio*1000000
	}
	method contaminacion(){
	return uranio>20	
	}
}

object centralExBosque{
	var capacidadTon = 20
	
	method produccion(ciudad) {
		return 0.5*1000000+capacidadTon*ciudad.tierra()*1000000
	}
	method contaminacion(){
		return true
	}
}

object centralElSuspiro{
	var turbinas = [turbina1]
	
	method produccion(ciudad){
		return turbinas.sum({turbina => turbina.produccionTurbina(ciudad)})
	}
	method contaminacion(){
		return false
	}
}

object turbina1{
	method produccionTurbina(ciudad){
		return 0.2*1000000*ciudad.vientos()
	}
}

object albuquerque{
	var caudal = 150
	var centralActual = hidroelectrica
	
	method caudal(){
		return caudal
	}
	method centralActual(){
		return centralActual
	}
	method laMejor(){
		return centralActual //solo tiene espacio para una central
	}
}

object hidroelectrica{
	method produccion(ciudad){
		return 2*1000000*ciudad.caudal()
	}
}

object region{
	var ciudades = [albuquerque, springfield]
	
	method mayoresProductores(){
		return ciudades.map({ciudad => ciudad.laMejor()})
	}
}