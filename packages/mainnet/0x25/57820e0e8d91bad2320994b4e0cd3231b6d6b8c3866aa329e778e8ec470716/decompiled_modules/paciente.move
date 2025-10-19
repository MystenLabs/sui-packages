module 0x2557820e0e8d91bad2320994b4e0cd3231b6d6b8c3866aa329e778e8ec470716::paciente {
    struct Paciente has drop, store {
        id: u64,
        nombre: 0x1::string::String,
        edad: u8,
        historial_ids: vector<u64>,
        historial_detalles: vector<0x1::string::String>,
    }

    public fun agregar_historial(arg0: &mut Paciente, arg1: u64, arg2: 0x1::string::String) {
        0x1::vector::push_back<u64>(&mut arg0.historial_ids, arg1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.historial_detalles, arg2);
    }

    public fun crear_paciente(arg0: u64, arg1: 0x1::string::String, arg2: u8) : Paciente {
        Paciente{
            id                 : arg0,
            nombre             : arg1,
            edad               : arg2,
            historial_ids      : 0x1::vector::empty<u64>(),
            historial_detalles : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun edad(arg0: &Paciente) : u8 {
        arg0.edad
    }

    public fun get_id(arg0: &Paciente) : u64 {
        arg0.id
    }

    public fun historial_len(arg0: &Paciente) : u64 {
        0x1::vector::length<u64>(&arg0.historial_ids)
    }

    public fun historial_vacio(arg0: &Paciente) : bool {
        0x1::vector::length<u64>(&arg0.historial_ids) == 0
    }

    public fun incrementar_edad(arg0: &mut Paciente) {
        arg0.edad = arg0.edad + 1;
    }

    public fun nombre(arg0: &Paciente) : &0x1::string::String {
        &arg0.nombre
    }

    public fun obtener_info(arg0: &Paciente) : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    // decompiled from Move bytecode v6
}

