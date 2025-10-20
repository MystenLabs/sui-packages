module 0xad779e95f0fd551ac4d86f5fe0b297a80988a288d7cb7d56bb47fd8c7d01cf92::lista_alumnos {
    struct Clase has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        alumnos: 0x2::vec_map::VecMap<u8, Alumno>,
    }

    struct Alumno has copy, drop, store {
        nombre: 0x1::string::String,
        edad: u8,
        calificaciones: vector<u8>,
    }

    public fun agregar_alumno(arg0: &mut Clase, arg1: u8, arg2: 0x1::string::String, arg3: u8) {
        assert!(!0x2::vec_map::contains<u8, Alumno>(&arg0.alumnos, &arg1), 13906834350437040129);
        let v0 = Alumno{
            nombre         : arg2,
            edad           : arg3,
            calificaciones : 0x1::vector::empty<u8>(),
        };
        0x2::vec_map::insert<u8, Alumno>(&mut arg0.alumnos, arg1, v0);
    }

    public fun agregar_calificacion(arg0: &mut Clase, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Alumno>(&arg0.alumnos, &arg1), 13906834406271746051);
        0x1::vector::push_back<u8>(&mut 0x2::vec_map::get_mut<u8, Alumno>(&mut arg0.alumnos, &arg1).calificaciones, arg2);
    }

    public fun crear_clase(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Clase{
            id      : 0x2::object::new(arg1),
            nombre  : arg0,
            alumnos : 0x2::vec_map::empty<u8, Alumno>(),
        };
        0x2::transfer::transfer<Clase>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_alumno(arg0: &mut Clase, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Alumno>(&arg0.alumnos, &arg1), 13906834539415732227);
        let (_, _) = 0x2::vec_map::remove<u8, Alumno>(&mut arg0.alumnos, &arg1);
    }

    public fun obtener_promedio(arg0: &mut Clase, arg1: u8) : u8 {
        assert!(0x2::vec_map::contains<u8, Alumno>(&arg0.alumnos, &arg1), 13906834440631484419);
        let v0 = &0x2::vec_map::get<u8, Alumno>(&arg0.alumnos, &arg1).calificaciones;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            v1 = v1 + (*0x1::vector::borrow<u8>(v0, v2) as u64);
            v2 = v2 + 1;
        };
        if (v2 == 0) {
            0
        } else {
            ((v1 / v2) as u8)
        }
    }

    // decompiled from Move bytecode v6
}

