module 0x91872482231187ad95698c29e9f5c30243a3847cd3101a56a796bf1a0a9b4a0a::Floristeria {
    struct Floristeria has store, key {
        id: 0x2::object::UID,
        ramos: 0x2::vec_map::VecMap<u64, Ramillete>,
    }

    struct Ramillete has copy, drop, store {
        titulo: 0x1::string::String,
        tipo: 0x1::string::String,
        precio: u16,
        disponible: bool,
    }

    public fun actualizar_disponibilidad(arg0: &mut Floristeria, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 11);
        0x2::vec_map::get_mut<u64, Ramillete>(&mut arg0.ramos, &arg1).disponible = arg2;
    }

    public fun actualizar_precio(arg0: &mut Floristeria, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 11);
        0x2::vec_map::get_mut<u64, Ramillete>(&mut arg0.ramos, &arg1).precio = arg2;
    }

    public fun actualizar_tipo(arg0: &mut Floristeria, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 11);
        0x2::vec_map::get_mut<u64, Ramillete>(&mut arg0.ramos, &arg1).tipo = arg2;
    }

    public fun actualizar_titulo(arg0: &mut Floristeria, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 11);
        0x2::vec_map::get_mut<u64, Ramillete>(&mut arg0.ramos, &arg1).titulo = arg2;
    }

    public fun agregar_ramillete(arg0: &mut Floristeria, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool) {
        let v0 = Ramillete{
            titulo     : arg2,
            tipo       : arg3,
            precio     : arg4,
            disponible : arg5,
        };
        assert!(!0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 10);
        0x2::vec_map::insert<u64, Ramillete>(&mut arg0.ramos, arg1, v0);
    }

    public fun borrar_ramillete(arg0: &mut Floristeria, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Ramillete>(&arg0.ramos, &arg1), 11);
        let (_, _) = 0x2::vec_map::remove<u64, Ramillete>(&mut arg0.ramos, &arg1);
    }

    public fun crear_floristeria(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Floristeria{
            id    : 0x2::object::new(arg0),
            ramos : 0x2::vec_map::empty<u64, Ramillete>(),
        };
        0x2::transfer::transfer<Floristeria>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_floristeria(arg0: Floristeria) {
        let Floristeria {
            id    : v0,
            ramos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

