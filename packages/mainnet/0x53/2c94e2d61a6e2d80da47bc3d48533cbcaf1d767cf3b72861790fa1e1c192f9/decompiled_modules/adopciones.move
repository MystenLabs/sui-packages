module 0x532c94e2d61a6e2d80da47bc3d48533cbcaf1d767cf3b72861790fa1e1c192f9::adopciones {
    struct RegistroAdopciones has key {
        id: 0x2::object::UID,
        nombre_registro: 0x1::string::String,
        contador_mascotas: u64,
        mascotas: 0x2::vec_map::VecMap<u64, Mascota>,
    }

    struct Mascota has copy, drop, store {
        nombre: 0x1::string::String,
        raza: 0x1::string::String,
        adoptante: 0x1::string::String,
        fecha_adopcion: 0x1::string::String,
    }

    public fun actualizar_adoptante(arg0: u64, arg1: 0x1::string::String, arg2: &mut RegistroAdopciones) {
        0x2::vec_map::get_mut<u64, Mascota>(&mut arg2.mascotas, &arg0).adoptante = arg1;
    }

    public fun crear_registro(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistroAdopciones{
            id                : 0x2::object::new(arg1),
            nombre_registro   : arg0,
            contador_mascotas : 0,
            mascotas          : 0x2::vec_map::empty<u64, Mascota>(),
        };
        0x2::transfer::transfer<RegistroAdopciones>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun elimiar_registro(arg0: RegistroAdopciones) {
        let RegistroAdopciones {
            id                : v0,
            nombre_registro   : _,
            contador_mascotas : _,
            mascotas          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun elminar_mascota(arg0: u64, arg1: &mut RegistroAdopciones) {
        let (_, _) = 0x2::vec_map::remove<u64, Mascota>(&mut arg1.mascotas, &arg0);
    }

    public fun obtener_mascota(arg0: u64, arg1: &RegistroAdopciones) : Mascota {
        assert!(0x2::vec_map::contains<u64, Mascota>(&arg1.mascotas, &arg0), 1);
        *0x2::vec_map::get<u64, Mascota>(&arg1.mascotas, &arg0)
    }

    public fun registrar_mascota(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut RegistroAdopciones) {
        let v0 = Mascota{
            nombre         : arg0,
            raza           : arg1,
            adoptante      : arg2,
            fecha_adopcion : arg3,
        };
        arg4.contador_mascotas = arg4.contador_mascotas + 1;
        0x2::vec_map::insert<u64, Mascota>(&mut arg4.mascotas, arg4.contador_mascotas, v0);
    }

    public fun total_mascotas(arg0: &RegistroAdopciones) : u64 {
        0x2::vec_map::length<u64, Mascota>(&arg0.mascotas)
    }

    // decompiled from Move bytecode v6
}

