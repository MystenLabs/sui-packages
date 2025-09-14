module 0xcbefe39a31db6d2cfbaa8c601a199e76c5dfde6fe5776f5b43d9e14db8c783db::app {
    struct Conductor has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        coche: 0x1::string::String,
        disponible: bool,
        propietario: address,
    }

    struct RegistroConductores has store, key {
        id: 0x2::object::UID,
        conductores_registrados: 0x2::vec_set::VecSet<address>,
        total_conductores: u64,
    }

    struct Pasajero has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        wallet: address,
    }

    struct RegistroPasajeros has store, key {
        id: 0x2::object::UID,
        pasajeros_registrados: 0x2::vec_set::VecSet<address>,
        total_pasajeros: u64,
    }

    struct Viaje has store, key {
        id: 0x2::object::UID,
        conductor_nombre: 0x1::string::String,
        pasajero_nombre: 0x1::string::String,
        origen: 0x1::string::String,
        destino: 0x1::string::String,
        activo: bool,
    }

    public fun actualizar_disponibilidad_conductor(arg0: &mut Conductor, arg1: bool) {
        arg0.disponible = arg1;
    }

    public fun crear_conductor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Conductor{
            id          : 0x2::object::new(arg2),
            nombre      : arg0,
            coche       : arg1,
            disponible  : true,
            propietario : v0,
        };
        0x2::transfer::transfer<Conductor>(v1, v0);
    }

    public fun crear_registro(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistroConductores{
            id                      : 0x2::object::new(arg0),
            conductores_registrados : 0x2::vec_set::empty<address>(),
            total_conductores       : 0,
        };
        0x2::transfer::share_object<RegistroConductores>(v0);
    }

    public fun crear_registro_pasajeros(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistroPasajeros{
            id                    : 0x2::object::new(arg0),
            pasajeros_registrados : 0x2::vec_set::empty<address>(),
            total_pasajeros       : 0,
        };
        0x2::transfer::share_object<RegistroPasajeros>(v0);
    }

    public fun crear_viaje(arg0: &mut Conductor, arg1: &Pasajero, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.disponible, 1);
        arg0.disponible = false;
        let v0 = Viaje{
            id               : 0x2::object::new(arg4),
            conductor_nombre : arg0.nombre,
            pasajero_nombre  : arg1.nombre,
            origen           : arg2,
            destino          : arg3,
            activo           : true,
        };
        0x2::transfer::transfer<Viaje>(v0, arg0.propietario);
    }

    public fun crear_viaje_vacio(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Viaje {
        Viaje{
            id               : 0x2::object::new(arg2),
            conductor_nombre : 0x1::string::utf8(b""),
            pasajero_nombre  : 0x1::string::utf8(b""),
            origen           : arg0,
            destino          : arg1,
            activo           : false,
        }
    }

    public fun eliminar_registro(arg0: RegistroConductores) {
        let RegistroConductores {
            id                      : v0,
            conductores_registrados : _,
            total_conductores       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_registro_pasajeros(arg0: RegistroPasajeros) {
        let RegistroPasajeros {
            id                    : v0,
            pasajeros_registrados : _,
            total_pasajeros       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun esta_activo(arg0: &Viaje) : bool {
        arg0.activo
    }

    public fun esta_conductor_registrado(arg0: &RegistroConductores, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.conductores_registrados, &arg1)
    }

    public fun esta_disponible(arg0: &Conductor) : bool {
        arg0.disponible
    }

    public fun esta_pasajero_registrado(arg0: &RegistroPasajeros, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.pasajeros_registrados, &arg1)
    }

    public fun finalizar_viaje(arg0: &mut Viaje, arg1: &mut Conductor) {
        arg0.activo = false;
        arg1.disponible = true;
    }

    public fun registrar_conductor(arg0: &mut RegistroConductores, arg1: Conductor) {
        let v0 = arg1.propietario;
        assert!(!0x2::vec_set::contains<address>(&arg0.conductores_registrados, &v0), 1);
        0x2::vec_set::insert<address>(&mut arg0.conductores_registrados, v0);
        arg0.total_conductores = arg0.total_conductores + 1;
        0x2::transfer::transfer<Conductor>(arg1, v0);
    }

    public fun registrar_pasajero(arg0: &mut RegistroPasajeros, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Pasajero{
            id     : 0x2::object::new(arg2),
            nombre : arg1,
            wallet : v0,
        };
        assert!(!0x2::vec_set::contains<address>(&arg0.pasajeros_registrados, &v1.wallet), 1);
        0x2::vec_set::insert<address>(&mut arg0.pasajeros_registrados, v1.wallet);
        arg0.total_pasajeros = arg0.total_pasajeros + 1;
        0x2::transfer::transfer<Pasajero>(v1, v0);
    }

    public fun reservar_viaje(arg0: &mut Viaje, arg1: &mut Conductor, arg2: &Pasajero) {
        assert!(arg1.disponible, 1);
        arg1.disponible = false;
        arg0.conductor_nombre = arg1.nombre;
        arg0.pasajero_nombre = arg2.nombre;
        arg0.activo = true;
    }

    // decompiled from Move bytecode v6
}

