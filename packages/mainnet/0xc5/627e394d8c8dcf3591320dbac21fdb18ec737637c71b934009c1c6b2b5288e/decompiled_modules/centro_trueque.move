module 0xc5627e394d8c8dcf3591320dbac21fdb18ec737637c71b934009c1c6b2b5288e::centro_trueque {
    struct GuardarropaCreatedEvent has copy, drop {
        guardarropa_id: 0x2::object::ID,
        registro_id: 0x2::object::ID,
        creador: address,
    }

    struct CarnetObtainedEvent has copy, drop {
        carnet_id: 0x2::object::ID,
        propietario: address,
    }

    struct ArticuloAlmacenadoEvent has copy, drop {
        guardarropa_id: 0x2::object::ID,
        clave: u64,
        depositante: address,
        nombre_articulo: 0x1::string::String,
    }

    struct ArticuloRetiradoEvent has copy, drop {
        guardarropa_id: 0x2::object::ID,
        clave: u64,
        retirador: address,
        nombre_articulo: 0x1::string::String,
    }

    struct ArticuloAlmacenado has copy, drop, store {
        nombre: 0x1::string::String,
        descripcion: 0x1::string::String,
        fecha_creacion: u64,
        propietario_original: address,
    }

    struct CarnetDeSocio has store, key {
        id: 0x2::object::UID,
        creditos_activos: 0x2::vec_map::VecMap<u64, bool>,
        propietario: address,
    }

    struct RegistroDeSocios has key {
        id: 0x2::object::UID,
        socios_registrados: 0x2::vec_set::VecSet<address>,
        total_socios: u64,
        creador: address,
    }

    struct GuardarropaDigital has key {
        id: 0x2::object::UID,
        articulos_almacenados: 0x2::vec_map::VecMap<u64, ArticuloAlmacenado>,
        siguiente_clave: u64,
        total_articulos: u64,
        creador: address,
    }

    struct Coleccionable has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        descripcion: 0x1::string::String,
        fecha_creacion: u64,
        propietario_original: address,
    }

    public fun actualizar_nombre_coleccionable(arg0: &mut Coleccionable, arg1: 0x1::string::String) {
        arg0.nombre = arg1;
    }

    public fun almacenar_articulo(arg0: &mut GuardarropaDigital, arg1: &mut CarnetDeSocio, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.propietario == 0x2::tx_context::sender(arg4), 13906834947437756421);
        let v0 = arg0.siguiente_clave;
        arg0.siguiente_clave = v0 + 1;
        arg0.total_articulos = arg0.total_articulos + 1;
        let v1 = ArticuloAlmacenado{
            nombre               : arg2,
            descripcion          : arg3,
            fecha_creacion       : 0x2::tx_context::epoch_timestamp_ms(arg4),
            propietario_original : 0x2::tx_context::sender(arg4),
        };
        assert!(!0x2::vec_map::contains<u64, ArticuloAlmacenado>(&arg0.articulos_almacenados, &v0), 13906835016157102083);
        0x2::vec_map::insert<u64, ArticuloAlmacenado>(&mut arg0.articulos_almacenados, v0, v1);
        0x2::vec_map::insert<u64, bool>(&mut arg1.creditos_activos, v0, true);
        let v2 = ArticuloAlmacenadoEvent{
            guardarropa_id  : 0x2::object::uid_to_inner(&arg0.id),
            clave           : v0,
            depositante     : 0x2::tx_context::sender(arg4),
            nombre_articulo : arg2,
        };
        0x2::event::emit<ArticuloAlmacenadoEvent>(v2);
    }

    public fun consultar_info_articulo(arg0: &GuardarropaDigital, arg1: u64) : (0x1::string::String, 0x1::string::String, u64, address) {
        assert!(0x2::vec_map::contains<u64, ArticuloAlmacenado>(&arg0.articulos_almacenados, &arg1), 13906835333984550913);
        let v0 = 0x2::vec_map::get<u64, ArticuloAlmacenado>(&arg0.articulos_almacenados, &arg1);
        (v0.nombre, v0.descripcion, v0.fecha_creacion, v0.propietario_original)
    }

    public fun consultar_siguiente_clave(arg0: &GuardarropaDigital) : u64 {
        arg0.siguiente_clave
    }

    public fun contar_creditos_activos(arg0: &CarnetDeSocio) : u64 {
        0x2::vec_map::size<u64, bool>(&arg0.creditos_activos)
    }

    public fun crear_guardarropa(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GuardarropaDigital{
            id                    : 0x2::object::new(arg0),
            articulos_almacenados : 0x2::vec_map::empty<u64, ArticuloAlmacenado>(),
            siguiente_clave       : 0,
            total_articulos       : 0,
            creador               : 0x2::tx_context::sender(arg0),
        };
        let v1 = RegistroDeSocios{
            id                 : 0x2::object::new(arg0),
            socios_registrados : 0x2::vec_set::empty<address>(),
            total_socios       : 0,
            creador            : 0x2::tx_context::sender(arg0),
        };
        let v2 = GuardarropaCreatedEvent{
            guardarropa_id : 0x2::object::uid_to_inner(&v0.id),
            registro_id    : 0x2::object::uid_to_inner(&v1.id),
            creador        : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<GuardarropaCreatedEvent>(v2);
        0x2::transfer::share_object<GuardarropaDigital>(v0);
        0x2::transfer::share_object<RegistroDeSocios>(v1);
    }

    public fun esta_usuario_registrado(arg0: &RegistroDeSocios, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.socios_registrados, &arg1)
    }

    public fun existe_articulo_en_guardarropa(arg0: &GuardarropaDigital, arg1: u64) : bool {
        0x2::vec_map::contains<u64, ArticuloAlmacenado>(&arg0.articulos_almacenados, &arg1)
    }

    public fun obtener_carnet_de_socio(arg0: &mut RegistroDeSocios, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::vec_set::contains<address>(&arg0.socios_registrados, &v0), 13906834805703966727);
        0x2::vec_set::insert<address>(&mut arg0.socios_registrados, v0);
        arg0.total_socios = arg0.total_socios + 1;
        let v1 = CarnetDeSocio{
            id               : 0x2::object::new(arg1),
            creditos_activos : 0x2::vec_map::empty<u64, bool>(),
            propietario      : v0,
        };
        let v2 = CarnetObtainedEvent{
            carnet_id   : 0x2::object::uid_to_inner(&v1.id),
            propietario : v0,
        };
        0x2::event::emit<CarnetObtainedEvent>(v2);
        0x2::transfer::transfer<CarnetDeSocio>(v1, v0);
    }

    public fun obtener_total_articulos_almacenados(arg0: &GuardarropaDigital) : u64 {
        arg0.total_articulos
    }

    public fun obtener_total_socios(arg0: &RegistroDeSocios) : u64 {
        arg0.total_socios
    }

    public fun retirar_articulo(arg0: &mut GuardarropaDigital, arg1: &mut CarnetDeSocio, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.propietario == 0x2::tx_context::sender(arg3), 13906835132121350149);
        assert!(0x2::vec_map::contains<u64, ArticuloAlmacenado>(&arg0.articulos_almacenados, &arg2), 13906835145005989889);
        assert!(0x2::vec_map::contains<u64, bool>(&arg1.creditos_activos, &arg2), 13906835157890891777);
        let (_, v1) = 0x2::vec_map::remove<u64, ArticuloAlmacenado>(&mut arg0.articulos_almacenados, &arg2);
        let v2 = v1;
        arg0.total_articulos = arg0.total_articulos - 1;
        let (_, _) = 0x2::vec_map::remove<u64, bool>(&mut arg1.creditos_activos, &arg2);
        let v5 = Coleccionable{
            id                   : 0x2::object::new(arg3),
            nombre               : v2.nombre,
            descripcion          : v2.descripcion,
            fecha_creacion       : v2.fecha_creacion,
            propietario_original : v2.propietario_original,
        };
        let v6 = ArticuloRetiradoEvent{
            guardarropa_id  : 0x2::object::uid_to_inner(&arg0.id),
            clave           : arg2,
            retirador       : 0x2::tx_context::sender(arg3),
            nombre_articulo : v2.nombre,
        };
        0x2::event::emit<ArticuloRetiradoEvent>(v6);
        0x2::transfer::transfer<Coleccionable>(v5, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

