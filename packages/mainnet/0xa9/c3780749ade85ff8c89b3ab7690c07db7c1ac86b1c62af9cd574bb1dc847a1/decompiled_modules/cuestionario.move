module 0xa9c3780749ade85ff8c89b3ab7690c07db7c1ac86b1c62af9cd574bb1dc847a1::cuestionario {
    struct PreguntasDePeliculas has key {
        id: 0x2::object::UID,
        pelicula: vector<0x1::string::String>,
        genero: 0x1::string::String,
        fecha: u16,
        adaptacion_literaria: bool,
    }

    struct PreguntasDeJuegos has key {
        id: 0x2::object::UID,
        games: vector<0x1::string::String>,
        categoria: 0x1::string::String,
        fecha: u16,
    }

    public fun add(arg0: &mut PreguntasDePeliculas, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.pelicula, arg1);
    }

    public fun mostrar_pregunta(arg0: &PreguntasDePeliculas) {
    }

    public fun mostrar_pregunta2(arg0: &PreguntasDeJuegos) {
    }

    public fun preguntas_juegos(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PreguntasDeJuegos{
            id        : 0x2::object::new(arg0),
            games     : 0x1::vector::empty<0x1::string::String>(),
            categoria : 0x1::string::utf8(x"4a7565676f20646520436f6e73747275636369c3b36e"),
            fecha     : 2009,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v0.games, 0x1::string::utf8(b"Minecraft"));
        0x2::transfer::transfer<PreguntasDeJuegos>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PreguntasDeJuegos{
            id        : 0x2::object::new(arg0),
            games     : 0x1::vector::empty<0x1::string::String>(),
            categoria : 0x1::string::utf8(x"41636369c3b36e"),
            fecha     : 1998,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v1.games, 0x1::string::utf8(b"The Legend of Zelda"));
        0x2::transfer::transfer<PreguntasDeJuegos>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PreguntasDeJuegos{
            id        : 0x2::object::new(arg0),
            games     : 0x1::vector::empty<0x1::string::String>(),
            categoria : 0x1::string::utf8(b"Juego de Rol: RPG"),
            fecha     : 2015,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v2.games, 0x1::string::utf8(b"The Witcher 3: Wild Hunt"));
        0x2::transfer::transfer<PreguntasDeJuegos>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun preguntas_pelis(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PreguntasDePeliculas{
            id                   : 0x2::object::new(arg0),
            pelicula             : 0x1::vector::empty<0x1::string::String>(),
            genero               : 0x1::string::utf8(b"Fantasia y Aventura"),
            fecha                : 2001,
            adaptacion_literaria : true,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v0.pelicula, 0x1::string::utf8(x"456c207365c3b16f72206465206c6f7320616e696c6c6f73"));
        0x2::transfer::transfer<PreguntasDePeliculas>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PreguntasDePeliculas{
            id                   : 0x2::object::new(arg0),
            pelicula             : 0x1::vector::empty<0x1::string::String>(),
            genero               : 0x1::string::utf8(b"Fantasia y Aventura"),
            fecha                : 2001,
            adaptacion_literaria : true,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v1.pelicula, 0x1::string::utf8(b"Harry Potter"));
        0x2::transfer::transfer<PreguntasDePeliculas>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PreguntasDePeliculas{
            id                   : 0x2::object::new(arg0),
            pelicula             : 0x1::vector::empty<0x1::string::String>(),
            genero               : 0x1::string::utf8(b"Drama y Romance"),
            fecha                : 2005,
            adaptacion_literaria : true,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v2.pelicula, 0x1::string::utf8(b"Orgullo y Prejuicio"));
        0x2::transfer::transfer<PreguntasDePeliculas>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun test(arg0: &mut 0x2::tx_context::TxContext) {
        preguntas_pelis(arg0);
        preguntas_juegos(arg0);
    }

    // decompiled from Move bytecode v6
}

