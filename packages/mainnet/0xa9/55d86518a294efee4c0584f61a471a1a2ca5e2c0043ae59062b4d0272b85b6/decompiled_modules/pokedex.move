module 0xa955d86518a294efee4c0584f61a471a1a2ca5e2c0043ae59062b4d0272b85b6::pokedex {
    struct Pokedex has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        pokemons: 0x2::vec_map::VecMap<u16, Pokemon>,
    }

    struct Pokemon has drop, store {
        numero: u16,
        nombre: 0x1::string::String,
        region: 0x1::string::String,
        tipos: vector<0x1::string::String>,
        descripcion: 0x1::string::String,
        peso: u64,
        altura: u64,
        habilidades: vector<0x1::string::String>,
        estadisticas: vector<u8>,
        cadena_evolutiva: vector<0x1::string::String>,
        ubicaciones: vector<0x1::string::String>,
        movimientos_nivel: vector<0x1::string::String>,
        movimientos_mt: vector<0x1::string::String>,
        movimientos_huevo: vector<0x1::string::String>,
    }

    public fun agregar_pokemon(arg0: &mut Pokedex, arg1: u16, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: vector<0x1::string::String>, arg9: vector<u8>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>) {
        assert!(!0x2::vec_map::contains<u16, Pokemon>(&arg0.pokemons, &arg1), 13906834453516255233);
        let v0 = Pokemon{
            numero            : arg1,
            nombre            : arg2,
            region            : arg3,
            tipos             : arg4,
            descripcion       : arg5,
            peso              : arg6,
            altura            : arg7,
            habilidades       : arg8,
            estadisticas      : arg9,
            cadena_evolutiva  : arg10,
            ubicaciones       : arg11,
            movimientos_nivel : arg12,
            movimientos_mt    : arg13,
            movimientos_huevo : arg14,
        };
        0x2::vec_map::insert<u16, Pokemon>(&mut arg0.pokemons, arg1, v0);
    }

    public fun buscar_por_region(arg0: &Pokedex, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Pokemon de la region ");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"3a0a"));
        let v1 = 0x2::vec_map::keys<u16, Pokemon>(&arg0.pokemons);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v1)) {
            let v3 = 0x2::vec_map::get<u16, Pokemon>(&arg0.pokemons, 0x1::vector::borrow<u16>(&v1, v2));
            if (v3.region == arg1) {
                0x1::string::append(&mut v0, v3.nombre);
                0x1::string::append(&mut v0, 0x1::string::utf8(x"0a"));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun buscar_por_tipo(arg0: &Pokedex, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Pokemon por tipo ");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a"));
        let v1 = 0x2::vec_map::keys<u16, Pokemon>(&arg0.pokemons);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v1)) {
            let v3 = 0x2::vec_map::get<u16, Pokemon>(&arg0.pokemons, 0x1::vector::borrow<u16>(&v1, v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(&v3.tipos)) {
                if (*0x1::vector::borrow<0x1::string::String>(&v3.tipos, v4) == arg1) {
                    0x1::string::append(&mut v0, v3.nombre);
                    0x1::string::append(&mut v0, 0x1::string::utf8(x"0a"));
                    break
                };
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun cantidad_pokemon(arg0: &Pokedex) : u64 {
        (0x2::vec_map::length<u16, Pokemon>(&arg0.pokemons) as u64)
    }

    public fun crear_pokedex(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Pokedex {
        Pokedex{
            id       : 0x2::object::new(arg1),
            nombre   : arg0,
            pokemons : 0x2::vec_map::empty<u16, Pokemon>(),
        }
    }

    public fun eliminar_pokemon(arg0: &mut Pokedex, arg1: u16) {
        assert!(0x2::vec_map::contains<u16, Pokemon>(&arg0.pokemons, &arg1), 13906834548005666819);
        let (_, _) = 0x2::vec_map::remove<u16, Pokemon>(&mut arg0.pokemons, &arg1);
    }

    public fun existe_pokemon(arg0: &Pokedex, arg1: u16) : bool {
        0x2::vec_map::contains<u16, Pokemon>(&arg0.pokemons, &arg1)
    }

    // decompiled from Move bytecode v6
}

