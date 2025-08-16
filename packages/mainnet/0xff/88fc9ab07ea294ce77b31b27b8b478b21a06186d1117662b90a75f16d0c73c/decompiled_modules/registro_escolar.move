module 0xff88fc9ab07ea294ce77b31b27b8b478b21a06186d1117662b90a75f16d0c73c::registro_escolar {
    struct RegistroEscolar has key {
        id: 0x2::object::UID,
        expedientes: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct ExpedienteDigital has store, key {
        id: 0x2::object::UID,
        nia: u64,
        nombre_completo: 0x1::string::String,
        curp: 0x1::string::String,
        telefono_tutor: u64,
        email_tutor: 0x1::string::String,
        grado: u64,
        grupo: 0x1::string::String,
    }

    public entry fun actualizar_contacto(arg0: &mut ExpedienteDigital, arg1: u64, arg2: 0x1::string::String) {
        arg0.telefono_tutor = arg1;
        arg0.email_tutor = arg2;
    }

    public entry fun asignar_grado_y_grupo(arg0: &RegistroEscolar, arg1: &mut ExpedienteDigital, arg2: u64, arg3: 0x1::string::String) {
        assert!(0x2::table::contains<u64, 0x2::object::ID>(&arg0.expedientes, arg1.nia), 0);
        arg1.grado = arg2;
        arg1.grupo = arg3;
    }

    public fun consultar_datos(arg0: &ExpedienteDigital) : (u64, 0x1::string::String, 0x1::string::String) {
        (arg0.nia, arg0.nombre_completo, arg0.curp)
    }

    public entry fun crear_escuela(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistroEscolar{
            id          : 0x2::object::new(arg0),
            expedientes : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<RegistroEscolar>(v0);
    }

    public entry fun inscribir_alumno(arg0: &mut RegistroEscolar, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExpedienteDigital{
            id              : 0x2::object::new(arg6),
            nia             : arg1,
            nombre_completo : arg2,
            curp            : arg3,
            telefono_tutor  : arg4,
            email_tutor     : arg5,
            grado           : 0,
            grupo           : 0x1::string::utf8(b"Sin asignar"),
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.expedientes, arg1, 0x2::object::id<ExpedienteDigital>(&v0));
        0x2::transfer::transfer<ExpedienteDigital>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

