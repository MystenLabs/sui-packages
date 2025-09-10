module 0x50a6b3eea3ad23adc43d7190b848e3dbaa8fdaa95bb5290963677beeb460648::registrocalificaciones {
    struct Registro has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        calificacion: 0x2::vec_map::VecMap<u8, Calificacion>,
    }

    struct Calificacion has drop, store {
        profesor: 0x1::string::String,
        materia: 0x1::string::String,
        numero: u8,
        semestre: u8,
        estado: 0x1::string::String,
    }

    public fun agregar_materias(arg0: &mut Registro, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8) {
        assert!(!0x2::vec_map::contains<u8, Calificacion>(&arg0.calificacion, &arg3), 13906834354732007425);
        let v0 = Calificacion{
            profesor : arg1,
            materia  : arg2,
            numero   : arg3,
            semestre : 0,
            estado   : 0x1::string::utf8(b"Calificacion Excelente"),
        };
        0x2::vec_map::insert<u8, Calificacion>(&mut arg0.calificacion, arg3, v0);
    }

    public fun alta_calificacion(arg0: &mut Registro, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Calificacion>(&arg0.calificacion, &arg1), 13906834453516386307);
        let v0 = 0x2::vec_map::get_mut<u8, Calificacion>(&mut arg0.calificacion, &arg1);
        v0.semestre = arg2;
        v0.estado = 0x1::string::utf8(b"En Alta");
    }

    public fun baja_calificacion(arg0: &mut Registro, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Calificacion>(&arg0.calificacion, &arg1), 13906834414861680643);
        let v0 = 0x2::vec_map::get_mut<u8, Calificacion>(&mut arg0.calificacion, &arg1);
        v0.semestre = arg2;
        v0.estado = 0x1::string::utf8(b"En Baja");
    }

    public fun borrar_ruta(arg0: &mut Registro, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Calificacion>(&arg0.calificacion, &arg1), 13906834492171091971);
        let (_, _) = 0x2::vec_map::remove<u8, Calificacion>(&mut arg0.calificacion, &arg1);
    }

    public fun crear_registro(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registro{
            id           : 0x2::object::new(arg1),
            nombre       : arg0,
            calificacion : 0x2::vec_map::empty<u8, Calificacion>(),
        };
        0x2::transfer::transfer<Registro>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

