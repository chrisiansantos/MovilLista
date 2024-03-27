class Usuarios {
  int edad;
  String bachillerato;
  String universidad;
  String nombreCompleto;
  String profesion;
  String urlImagen; 

  Usuarios({
    required this.nombreCompleto,
    required this.profesion,
    required this.urlImagen, 
    required this.edad,
    required this.bachillerato,
    required this.universidad,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        nombreCompleto: json["nombreCompleto"],
        profesion: json["profesion"],
        urlImagen: json["urlImagen"], 
        edad: json["edad"],
        bachillerato: json["estudios"][0]["bachillerato"],
        universidad: json["estudios"][0]["universidad"],
      );
}
