module 0x2557820e0e8d91bad2320994b4e0cd3231b6d6b8c3866aa329e778e8ec470716::consulta_medica {
    struct Paciente has store {
        id: u64,
        nombre: 0x1::string::String,
        edad: u8,
    }

    struct Cita has store {
        id: u64,
        fecha: 0x1::string::String,
        hora: 0x1::string::String,
        paciente_id: u64,
        motivo: 0x1::string::String,
    }

    public fun crear_cita(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String) : Cita {
        Cita{
            id          : arg0,
            fecha       : arg1,
            hora        : arg2,
            paciente_id : arg3,
            motivo      : arg4,
        }
    }

    public fun crear_paciente(arg0: u64, arg1: 0x1::string::String, arg2: u8) : Paciente {
        Paciente{
            id     : arg0,
            nombre : arg1,
            edad   : arg2,
        }
    }

    public fun edad_paciente(arg0: &Paciente) : u8 {
        arg0.edad
    }

    public fun info_cita(arg0: &Cita) : (u64, &0x1::string::String, &0x1::string::String, u64, &0x1::string::String) {
        (arg0.id, &arg0.fecha, &arg0.hora, arg0.paciente_id, &arg0.motivo)
    }

    public fun nombre_paciente(arg0: &Paciente) : &0x1::string::String {
        &arg0.nombre
    }

    // decompiled from Move bytecode v6
}

