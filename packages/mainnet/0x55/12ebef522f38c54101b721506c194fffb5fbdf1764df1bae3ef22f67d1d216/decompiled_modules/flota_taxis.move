module 0x5512ebef522f38c54101b721506c194fffb5fbdf1764df1bae3ef22f67d1d216::flota_taxis {
    struct FlotaTaxis has key {
        id: 0x2::object::UID,
        taxis: 0x2::vec_map::VecMap<u64, Taxi>,
    }

    struct Taxi has drop, store {
        placa: 0x1::string::String,
        conductor: 0x1::string::String,
        modelo: u16,
        disponible: bool,
    }

    public fun agregar_taxi(arg0: &mut FlotaTaxis, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16) {
        assert!(!0x2::vec_map::contains<u64, Taxi>(&arg0.taxis, &arg1), 1);
        let v0 = Taxi{
            placa      : arg2,
            conductor  : arg3,
            modelo     : arg4,
            disponible : true,
        };
        0x2::vec_map::insert<u64, Taxi>(&mut arg0.taxis, arg1, v0);
    }

    public fun crear_flota(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlotaTaxis{
            id    : 0x2::object::new(arg0),
            taxis : 0x2::vec_map::empty<u64, Taxi>(),
        };
        0x2::transfer::transfer<FlotaTaxis>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun editar_conductor(arg0: &mut FlotaTaxis, arg1: u64, arg2: 0x1::string::String) {
        0x2::vec_map::get_mut<u64, Taxi>(&mut arg0.taxis, &arg1).conductor = arg2;
    }

    public fun editar_disponibilidad(arg0: &mut FlotaTaxis, arg1: u64, arg2: bool) {
        0x2::vec_map::get_mut<u64, Taxi>(&mut arg0.taxis, &arg1).disponible = arg2;
    }

    public fun editar_modelo(arg0: &mut FlotaTaxis, arg1: u64, arg2: u16) {
        0x2::vec_map::get_mut<u64, Taxi>(&mut arg0.taxis, &arg1).modelo = arg2;
    }

    public fun editar_placa(arg0: &mut FlotaTaxis, arg1: u64, arg2: 0x1::string::String) {
        0x2::vec_map::get_mut<u64, Taxi>(&mut arg0.taxis, &arg1).placa = arg2;
    }

    public fun eliminar_flota(arg0: FlotaTaxis) {
        let FlotaTaxis {
            id    : v0,
            taxis : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_taxi(arg0: &mut FlotaTaxis, arg1: u64) {
        let (_, _) = 0x2::vec_map::remove<u64, Taxi>(&mut arg0.taxis, &arg1);
    }

    // decompiled from Move bytecode v6
}

