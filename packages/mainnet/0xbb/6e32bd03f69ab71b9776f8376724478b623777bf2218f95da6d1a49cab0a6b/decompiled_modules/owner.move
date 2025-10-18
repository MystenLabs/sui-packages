module 0xbb6e32bd03f69ab71b9776f8376724478b623777bf2218f95da6d1a49cab0a6b::owner {
    struct Dueno has copy, drop {
        id: u64,
        nombre: vector<u8>,
        telefono: vector<u8>,
    }

    public fun actualizar_dueno(arg0: &mut Dueno, arg1: vector<u8>, arg2: vector<u8>) {
        arg0.nombre = arg1;
        arg0.telefono = arg2;
    }

    public fun crear_dueno(arg0: u64, arg1: vector<u8>, arg2: vector<u8>) : Dueno {
        Dueno{
            id       : arg0,
            nombre   : arg1,
            telefono : arg2,
        }
    }

    public fun dueno_id(arg0: &Dueno) : u64 {
        arg0.id
    }

    public fun dueno_nombre(arg0: &Dueno) : vector<u8> {
        arg0.nombre
    }

    public fun dueno_telefono(arg0: &Dueno) : vector<u8> {
        arg0.telefono
    }

    public fun eliminar_dueno(arg0: &mut Dueno) {
    }

    public fun leer_dueno(arg0: &Dueno) : (u64, vector<u8>, vector<u8>) {
        (arg0.id, arg0.nombre, arg0.telefono)
    }

    // decompiled from Move bytecode v6
}

