module 0xfab6907084c060672c939e602b4da9a943e63fc5504a45dd69462976f17edc37::hangman {
    struct Keywords has key {
        id: 0x2::object::UID,
        palabras: 0x2::vec_map::VecMap<u8, Palabra>,
    }

    struct Palabra has store {
        texto: 0x1::string::String,
        pista: 0x1::string::String,
    }

    struct Juego has key {
        id: 0x2::object::UID,
        jugador: address,
        palabra_id: u8,
        letras_adivinadas: vector<u8>,
        intentos_restantes: u8,
        finalizado: bool,
        partida: 0x1::option::Option<0x1::string::String>,
        ultima_letra: 0x1::option::Option<u8>,
    }

    public fun adivinar_letra(arg0: &mut Juego, arg1: &Keywords, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        validar_juego(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.letras_adivinadas)) {
            assert!(*0x1::vector::borrow<u8>(&arg0.letras_adivinadas, v0) != arg2, 13906834612430176259);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<u8>(&mut arg0.letras_adivinadas, arg2);
        arg0.ultima_letra = 0x1::option::some<u8>(arg2);
        let v1 = 0x1::string::as_bytes(&0x2::vec_map::get<u8, Palabra>(&arg1.palabras, &arg0.palabra_id).texto);
        if (!contiene_byte(v1, arg2)) {
            arg0.intentos_restantes = arg0.intentos_restantes - 1;
        };
        if (arg0.intentos_restantes == 0 || todas_letras_adivinadas(v1, &arg0.letras_adivinadas)) {
            arg0.finalizado = true;
            if (arg0.intentos_restantes > 0) {
                arg0.partida = 0x1::option::some<0x1::string::String>(0x1::string::utf8(x"f09f8e8920c2a147616e6173746521"));
            } else {
                arg0.partida = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"Perdiste"));
            };
        };
    }

    public fun agregar_palabra(arg0: &mut Keywords, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u8, Palabra>(&arg0.palabras, &arg1), 13906834479286059009);
        let v0 = Palabra{
            texto : arg2,
            pista : arg3,
        };
        0x2::vec_map::insert<u8, Palabra>(&mut arg0.palabras, arg1, v0);
    }

    fun contiene_byte(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun crear_juego(arg0: &Keywords, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        validar_palabra(arg0, arg1);
        let v0 = Juego{
            id                 : 0x2::object::new(arg2),
            jugador            : 0x2::tx_context::sender(arg2),
            palabra_id         : arg1,
            letras_adivinadas  : 0x1::vector::empty<u8>(),
            intentos_restantes : 6,
            finalizado         : false,
            partida            : 0x1::option::none<0x1::string::String>(),
            ultima_letra       : 0x1::option::none<u8>(),
        };
        0x2::transfer::transfer<Juego>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun crear_keywords(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Keywords{
            id       : 0x2::object::new(arg0),
            palabras : 0x2::vec_map::empty<u8, Palabra>(),
        };
        0x2::transfer::transfer<Keywords>(v0, 0x2::tx_context::sender(arg0));
    }

    fun letra_en_vector(arg0: u8, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            if (*0x1::vector::borrow<u8>(arg1, v0) == arg0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun todas_letras_adivinadas(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (!letra_en_vector(*0x1::vector::borrow<u8>(arg0, v0), arg1)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun validar_juego(arg0: &Juego, arg1: address) {
        assert!(!arg0.finalizado, 13906834380502073349);
        assert!(arg0.jugador == arg1, 13906834384797171719);
    }

    fun validar_palabra(arg0: &Keywords, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Palabra>(&arg0.palabras, &arg1), 13906834401977171977);
    }

    // decompiled from Move bytecode v6
}

