module 0xf220ef0d2dac418bf8f9b004ac7d64ac839b5b5fa424b86e3a5db4c0890c65e8::refugio {
    struct Refugio has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        contacto: 0x1::string::String,
        animales: 0x2::vec_map::VecMap<u8, Animal>,
    }

    struct Animal has copy, drop, store {
        nombre: 0x1::string::String,
        especie: 0x1::string::String,
        adoptado: bool,
    }

    public fun crear_refugio(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Refugio{
            id       : 0x2::object::new(arg2),
            nombre   : arg0,
            contacto : arg1,
            animales : 0x2::vec_map::empty<u8, Animal>(),
        };
        0x2::transfer::transfer<Refugio>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun eliminar_animal(arg0: &mut Refugio, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Animal>(&arg0.animales, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u8, Animal>(&mut arg0.animales, &arg1);
    }

    public fun eliminar_refugio(arg0: Refugio) {
        let Refugio {
            id       : v0,
            nombre   : _,
            contacto : _,
            animales : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun marcar_adoptado(arg0: &mut Refugio, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Animal>(&arg0.animales, &arg1), 2);
        0x2::vec_map::get_mut<u8, Animal>(&mut arg0.animales, &arg1).adoptado = true;
    }

    public fun registrar_animal(arg0: &mut Refugio, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u8, Animal>(&arg0.animales, &arg1), 1);
        let v0 = Animal{
            nombre   : arg2,
            especie  : arg3,
            adoptado : false,
        };
        0x2::vec_map::insert<u8, Animal>(&mut arg0.animales, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

