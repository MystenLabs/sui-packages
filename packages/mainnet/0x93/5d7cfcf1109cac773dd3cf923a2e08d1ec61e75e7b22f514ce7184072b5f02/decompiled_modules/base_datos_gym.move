module 0x935d7cfcf1109cac773dd3cf923a2e08d1ec61e75e7b22f514ce7184072b5f02::base_datos_gym {
    struct Gym has store, key {
        id: 0x2::object::UID,
        usuarios: 0x2::vec_map::VecMap<u64, Usuarios>,
    }

    struct Usuarios has copy, drop, store {
        nombre: 0x1::string::String,
        edad: u8,
        dni: u32,
        membresia_activa: bool,
    }

    public fun actualizar_membresia(arg0: &mut Gym, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Usuarios>(&arg0.usuarios, &arg1), 13906834432041549827);
        let v0 = 0x2::vec_map::get_mut<u64, Usuarios>(&mut arg0.usuarios, &arg1);
        v0.membresia_activa = !v0.membresia_activa;
    }

    public fun agregar_usuario(arg0: &mut Gym, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: u32) {
        assert!(!0x2::vec_map::contains<u64, Usuarios>(&arg0.usuarios, &arg1), 13906834324667236353);
        let v0 = Usuarios{
            nombre           : arg2,
            edad             : arg3,
            dni              : arg4,
            membresia_activa : true,
        };
        0x2::vec_map::insert<u64, Usuarios>(&mut arg0.usuarios, arg1, v0);
    }

    public fun crear_gimnacio(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gym{
            id       : 0x2::object::new(arg0),
            usuarios : 0x2::vec_map::empty<u64, Usuarios>(),
        };
        0x2::transfer::transfer<Gym>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun editar_usuario(arg0: &mut Gym, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: u32) {
        assert!(0x2::vec_map::contains<u64, Usuarios>(&arg0.usuarios, &arg1), 13906834393386844163);
        let (_, v1) = 0x2::vec_map::remove<u64, Usuarios>(&mut arg0.usuarios, &arg1);
        let v2 = v1;
        v2.nombre = arg2;
        v2.edad = arg3;
        v2.dni = arg4;
        0x2::vec_map::insert<u64, Usuarios>(&mut arg0.usuarios, arg1, v2);
    }

    public fun eliminar_usuario(arg0: &mut Gym, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Usuarios>(&arg0.usuarios, &arg1), 13906834371912007683);
        let (_, _) = 0x2::vec_map::remove<u64, Usuarios>(&mut arg0.usuarios, &arg1);
    }

    // decompiled from Move bytecode v6
}

