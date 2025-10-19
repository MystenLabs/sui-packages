module 0x2557820e0e8d91bad2320994b4e0cd3231b6d6b8c3866aa329e778e8ec470716::cita {
    struct Cita has drop, store {
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

    public fun detalles(arg0: &Cita) : (u64, &0x1::string::String, &0x1::string::String, u64, &0x1::string::String) {
        (arg0.id, &arg0.fecha, &arg0.hora, arg0.paciente_id, &arg0.motivo)
    }

    public fun es_para_paciente(arg0: &Cita, arg1: u64) : bool {
        arg0.paciente_id == arg1
    }

    public fun get_id(arg0: &Cita) : u64 {
        arg0.id
    }

    public fun get_paciente_id(arg0: &Cita) : u64 {
        arg0.paciente_id
    }

    // decompiled from Move bytecode v6
}

