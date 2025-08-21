module 0xbfbbc88d7fec117fbf1c9b97aeaa6e4d99f1cf1bdfeb5028164efe0c2d50f6f::camiones {
    struct Camiones has store, key {
        id: 0x2::object::UID,
        camion: 0x2::vec_map::VecMap<0x1::string::String, Camion>,
    }

    struct Camion has copy, drop, store {
        niv: 0x1::string::String,
        cliente: 0x1::string::String,
        fecha: 0x1::string::String,
        disponible: bool,
        ejes: u16,
    }

    public fun actualizar_camion(arg0: &mut Camiones, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::get_mut<0x1::string::String, Camion>(&mut arg0.camion, &arg1).cliente = arg2;
    }

    public fun agregar_camion(arg0: &mut Camiones, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: u16) {
        let v0 = Camion{
            niv        : arg1,
            cliente    : arg2,
            fecha      : arg3,
            disponible : arg4,
            ejes       : arg5,
        };
        assert!(v0.niv == arg1, 13906834359026974721);
        0x2::vec_map::insert<0x1::string::String, Camion>(&mut arg0.camion, arg1, v0);
    }

    public fun borrar_camion(arg0: &mut Camiones, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Camion>(&arg0.camion, &arg1), 13906834436336517123);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, Camion>(&mut arg0.camion, &arg1);
    }

    public fun crear_camiones(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Camiones{
            id     : 0x2::object::new(arg0),
            camion : 0x2::vec_map::empty<0x1::string::String, Camion>(),
        };
        0x2::transfer::transfer<Camiones>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_camiones(arg0: Camiones) {
        let Camiones {
            id     : v0,
            camion : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

