module 0xbb6e32bd03f69ab71b9776f8376724478b623777bf2218f95da6d1a49cab0a6b::veterinaria {
    struct Mascota has drop, store {
        id: u64,
        nombre: vector<u8>,
        especie: vector<u8>,
        dueno_id: u64,
        edad: u64,
    }

    struct Dueno has drop, store {
        id: u64,
        nombre: vector<u8>,
        telefono: vector<u8>,
    }

    public fun actualizar_dueno(arg0: Dueno, arg1: vector<u8>, arg2: vector<u8>) : Dueno {
        Dueno{
            id       : arg0.id,
            nombre   : arg1,
            telefono : arg2,
        }
    }

    public fun actualizar_mascota(arg0: Mascota, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : Mascota {
        Mascota{
            id       : arg0.id,
            nombre   : arg1,
            especie  : arg2,
            dueno_id : arg0.dueno_id,
            edad     : arg3,
        }
    }

    public fun crear_dueno(arg0: u64, arg1: vector<u8>, arg2: vector<u8>) : Dueno {
        Dueno{
            id       : arg0,
            nombre   : arg1,
            telefono : arg2,
        }
    }

    public fun crear_mascota(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) : Mascota {
        Mascota{
            id       : arg0,
            nombre   : arg1,
            especie  : arg2,
            dueno_id : arg3,
            edad     : arg4,
        }
    }

    public fun dueno_id(arg0: Dueno) : u64 {
        arg0.id
    }

    public fun dueno_nombre(arg0: Dueno) : vector<u8> {
        arg0.nombre
    }

    public fun dueno_telefono(arg0: Dueno) : vector<u8> {
        arg0.telefono
    }

    public fun eliminar_dueno(arg0: Dueno) {
    }

    public fun eliminar_mascota(arg0: Mascota) {
    }

    public fun leer_dueno(arg0: u64) : 0x1::option::Option<Dueno> {
        0x1::option::none<Dueno>()
    }

    public fun leer_mascota(arg0: u64) : 0x1::option::Option<Mascota> {
        0x1::option::none<Mascota>()
    }

    public fun pet_dueno_id(arg0: Mascota) : u64 {
        arg0.dueno_id
    }

    public fun pet_edad(arg0: Mascota) : u64 {
        arg0.edad
    }

    public fun pet_especie(arg0: Mascota) : vector<u8> {
        arg0.especie
    }

    public fun pet_nombre(arg0: Mascota) : vector<u8> {
        arg0.nombre
    }

    // decompiled from Move bytecode v6
}

