module 0xaac5334b10c9ebbb97daedb9774bd62c7e4ab8055718cd6be6aad5adb047578d::practica_sui_gimnasio {
    struct Gimnasio has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        socio: vector<Socio>,
    }

    struct Socio has drop, store {
        nombre: 0x1::string::String,
        edad: u16,
        plan: 0x1::string::String,
        estado: 0x1::string::String,
    }

    public fun agregar_socio(arg0: &mut Gimnasio, arg1: 0x1::string::String, arg2: u16, arg3: 0x1::string::String) {
        let v0 = Socio{
            nombre : arg1,
            edad   : arg2,
            plan   : arg3,
            estado : 0x1::string::utf8(b"activo"),
        };
        0x1::vector::push_back<Socio>(&mut arg0.socio, v0);
    }

    public fun crear_gimnasio(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Gimnasio{
            id     : 0x2::object::new(arg1),
            nombre : arg0,
            socio  : 0x1::vector::empty<Socio>(),
        };
        0x2::transfer::transfer<Gimnasio>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun editar_estado(arg0: &mut Gimnasio, arg1: u64, arg2: 0x1::string::String) {
        assert!(arg1 < 0x1::vector::length<Socio>(&arg0.socio), 13906834376206843905);
        0x1::vector::borrow_mut<Socio>(&mut arg0.socio, arg1).estado = arg2;
    }

    public fun eliminar_socio(arg0: &mut Gimnasio, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<Socio>(&arg0.socio), 13906834354732007423);
        0x1::vector::remove<Socio>(&mut arg0.socio, arg1);
    }

    public fun eliminar_ultimo_socio(arg0: &mut Gimnasio) {
        0x1::vector::pop_back<Socio>(&mut arg0.socio);
    }

    // decompiled from Move bytecode v6
}

