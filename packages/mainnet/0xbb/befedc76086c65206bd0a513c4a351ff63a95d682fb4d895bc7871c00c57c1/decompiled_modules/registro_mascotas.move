module 0xbbbefedc76086c65206bd0a513c4a351ff63a95d682fb4d895bc7871c00c57c1::registro_mascotas {
    struct Mascota has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        especie: 0x1::string::String,
        raza: 0x1::string::String,
        dueno: address,
        fecha_registro: u64,
        vacunas: vector<Vacuna>,
        consultas: vector<Consulta>,
        activa: bool,
    }

    struct Vacuna has copy, drop, store {
        nombre: 0x1::string::String,
        fecha: u64,
        veterinario: address,
        lote: 0x1::string::String,
    }

    struct Consulta has copy, drop, store {
        motivo: 0x1::string::String,
        diagnostico: 0x1::string::String,
        tratamiento: 0x1::string::String,
        fecha: u64,
        veterinario: address,
    }

    struct InsigniaVeterinaria has store, key {
        id: 0x2::object::UID,
        tipo_logro: 0x1::string::String,
        descripcion: 0x1::string::String,
        mascota_id: 0x2::object::ID,
        fecha_obtencion: u64,
        emitida_por: address,
    }

    public entry fun actualizar_nombre_mascota(arg0: &mut Mascota, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dueno == 0x2::tx_context::sender(arg2), 100);
        arg0.nombre = 0x1::string::utf8(arg1);
    }

    public entry fun actualizar_raza_mascota(arg0: &mut Mascota, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dueno == 0x2::tx_context::sender(arg2), 100);
        arg0.raza = 0x1::string::utf8(arg1);
    }

    public entry fun agregar_consulta(arg0: &mut Mascota, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.activa, 101);
        let v1 = Consulta{
            motivo      : 0x1::string::utf8(arg1),
            diagnostico : 0x1::string::utf8(arg2),
            tratamiento : 0x1::string::utf8(arg3),
            fecha       : 0x2::clock::timestamp_ms(arg4),
            veterinario : v0,
        };
        0x1::vector::push_back<Consulta>(&mut arg0.consultas, v1);
        verificar_logro_revision_anual(arg0, v0, arg4, arg5);
    }

    public entry fun agregar_vacuna(arg0: &mut Mascota, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.activa, 101);
        let v1 = Vacuna{
            nombre      : 0x1::string::utf8(arg1),
            fecha       : 0x2::clock::timestamp_ms(arg3),
            veterinario : v0,
            lote        : 0x1::string::utf8(arg2),
        };
        0x1::vector::push_back<Vacuna>(&mut arg0.vacunas, v1);
        verificar_logro_vacunacion(arg0, v0, arg3, arg4);
    }

    public fun contar_consultas(arg0: &Mascota) : u64 {
        0x1::vector::length<Consulta>(&arg0.consultas)
    }

    public fun contar_vacunas(arg0: &Mascota) : u64 {
        0x1::vector::length<Vacuna>(&arg0.vacunas)
    }

    public entry fun crear_mascota(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Mascota{
            id             : 0x2::object::new(arg5),
            nombre         : 0x1::string::utf8(arg0),
            especie        : 0x1::string::utf8(arg1),
            raza           : 0x1::string::utf8(arg2),
            dueno          : arg3,
            fecha_registro : 0x2::clock::timestamp_ms(arg4),
            vacunas        : 0x1::vector::empty<Vacuna>(),
            consultas      : 0x1::vector::empty<Consulta>(),
            activa         : true,
        };
        0x2::transfer::public_transfer<Mascota>(v0, arg3);
    }

    public entry fun desactivar_mascota(arg0: &mut Mascota, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dueno == 0x2::tx_context::sender(arg1), 100);
        arg0.activa = false;
    }

    public entry fun eliminar_vacuna(arg0: &mut Mascota, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
        assert!(arg0.activa, 101);
        assert!(arg1 < 0x1::vector::length<Vacuna>(&arg0.vacunas), 102);
        0x1::vector::remove<Vacuna>(&mut arg0.vacunas, arg1);
    }

    public fun obtener_info_mascota(arg0: &Mascota) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, bool) {
        (arg0.nombre, arg0.especie, arg0.raza, arg0.dueno, arg0.activa)
    }

    public entry fun transferir_mascota(arg0: Mascota, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dueno == 0x2::tx_context::sender(arg2), 100);
        arg0.dueno = arg1;
        0x2::transfer::public_transfer<Mascota>(arg0, arg1);
    }

    fun verificar_logro_revision_anual(arg0: &Mascota, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<Consulta>(&arg0.consultas) >= 3) {
            let v0 = InsigniaVeterinaria{
                id              : 0x2::object::new(arg3),
                tipo_logro      : 0x1::string::utf8(b"Revision Anual completa"),
                descripcion     : 0x1::string::utf8(x"4d6173636f74612068612074656e69646f2033206f206dc3a17320636f6e73756c74617320616e75616c6573"),
                mascota_id      : 0x2::object::uid_to_inner(&arg0.id),
                fecha_obtencion : 0x2::clock::timestamp_ms(arg2),
                emitida_por     : arg1,
            };
            0x2::transfer::public_transfer<InsigniaVeterinaria>(v0, arg0.dueno);
        };
    }

    fun verificar_logro_vacunacion(arg0: &Mascota, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<Vacuna>(&arg0.vacunas) >= 3) {
            let v0 = InsigniaVeterinaria{
                id              : 0x2::object::new(arg3),
                tipo_logro      : 0x1::string::utf8(b"Vacunacion completa"),
                descripcion     : 0x1::string::utf8(x"4d6173636f746120686120726563696269646f2033206f206dc3a17320766163756e6173"),
                mascota_id      : 0x2::object::uid_to_inner(&arg0.id),
                fecha_obtencion : 0x2::clock::timestamp_ms(arg2),
                emitida_por     : arg1,
            };
            0x2::transfer::public_transfer<InsigniaVeterinaria>(v0, arg0.dueno);
        };
    }

    // decompiled from Move bytecode v6
}

