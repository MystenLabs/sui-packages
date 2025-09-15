module 0xbb175373f7d11cebeaab4f508eb53de723adf532b2801f5db2f3f2c6948254bc::votacion {
    struct Opcion has copy, drop, store {
        id: u64,
        descripcion: 0x1::string::String,
    }

    struct Propuesta has key {
        id: 0x2::object::UID,
        propietario: address,
        pregunta: 0x1::string::String,
        opciones: vector<Opcion>,
        votos_por_opcion: 0x2::vec_map::VecMap<u64, u64>,
        votantes: 0x2::vec_map::VecMap<address, bool>,
        finalizada: bool,
    }

    struct Boleta has store, key {
        id: 0x2::object::UID,
        propuesta_id: 0x2::object::ID,
    }

    struct Voto has store, key {
        id: 0x2::object::UID,
        propuesta_id: 0x2::object::ID,
        votante: address,
        opcion_elegida: u64,
    }

    public fun agregar_votante(arg0: &mut Propuesta, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 13906834526530699265);
        0x2::vec_map::insert<address, bool>(&mut arg0.votantes, arg1, false);
    }

    public fun crear_propuesta(arg0: 0x1::string::String, arg1: vector<Opcion>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Opcion>(&arg1)) {
            0x2::vec_map::insert<u64, u64>(&mut v0, 0x1::vector::borrow<Opcion>(&arg1, v1).id, 0);
            v1 = v1 + 1;
        };
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = Propuesta{
            id               : 0x2::object::new(arg2),
            propietario      : v2,
            pregunta         : arg0,
            opciones         : arg1,
            votos_por_opcion : v0,
            votantes         : 0x2::vec_map::empty<address, bool>(),
            finalizada       : false,
        };
        0x2::transfer::transfer<Propuesta>(v3, v2);
    }

    public fun crear_propuesta_simple(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Opcion{
            id          : arg1,
            descripcion : arg2,
        };
        let v1 = Opcion{
            id          : arg3,
            descripcion : arg4,
        };
        let v2 = 0x1::vector::empty<Opcion>();
        let v3 = &mut v2;
        0x1::vector::push_back<Opcion>(v3, v0);
        0x1::vector::push_back<Opcion>(v3, v1);
        crear_propuesta(arg0, v2, arg5);
    }

    public fun eliminar_propuesta(arg0: Propuesta, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg1), 13906834698329391105);
        let Propuesta {
            id               : v0,
            propietario      : _,
            pregunta         : _,
            opciones         : _,
            votos_por_opcion : v4,
            votantes         : v5,
            finalizada       : _,
        } = arg0;
        0x2::vec_map::destroy_empty<u64, u64>(v4);
        0x2::vec_map::destroy_empty<address, bool>(v5);
        0x2::object::delete(v0);
    }

    public fun emitir_boleta(arg0: &Propuesta, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalizada, 13906834548005666819);
        assert!(0x2::vec_map::contains<address, bool>(&arg0.votantes, &arg1), 13906834552300896263);
        let v0 = Boleta{
            id           : 0x2::object::new(arg2),
            propuesta_id : 0x2::object::id<Propuesta>(arg0),
        };
        0x2::transfer::transfer<Boleta>(v0, arg1);
    }

    public fun finalizar_votacion(arg0: &mut Propuesta, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg1), 13906834595250176001);
        arg0.finalizada = true;
    }

    public fun obtener_resultados(arg0: &Propuesta) : &0x2::vec_map::VecMap<u64, u64> {
        &arg0.votos_por_opcion
    }

    public fun votar(arg0: &mut Propuesta, arg1: Boleta, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Voto {
        assert!(!arg0.finalizada, 13906834801408737283);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<Propuesta>(arg0);
        assert!(&v1 == &arg1.propuesta_id, 13906834822883966985);
        assert!(0x2::vec_map::contains<address, bool>(&arg0.votantes, &v0), 13906834827178803207);
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.votos_por_opcion, &arg2), 13906834831474032651);
        assert!(!*0x2::vec_map::get<address, bool>(&arg0.votantes, &v0), 13906834844358541317);
        0x2::vec_map::insert<u64, u64>(&mut arg0.votos_por_opcion, arg2, *0x2::vec_map::get<u64, u64>(&arg0.votos_por_opcion, &arg2) + 1);
        0x2::vec_map::insert<address, bool>(&mut arg0.votantes, v0, true);
        let v2 = Voto{
            id             : 0x2::object::new(arg3),
            propuesta_id   : 0x2::object::id<Propuesta>(arg0),
            votante        : v0,
            opcion_elegida : arg2,
        };
        let Boleta {
            id           : v3,
            propuesta_id : _,
        } = arg1;
        0x2::object::delete(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

