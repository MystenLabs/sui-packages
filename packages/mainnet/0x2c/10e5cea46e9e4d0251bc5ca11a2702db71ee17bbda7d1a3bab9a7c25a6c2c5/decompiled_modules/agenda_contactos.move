module 0x2c10e5cea46e9e4d0251bc5ca11a2702db71ee17bbda7d1a3bab9a7c25a6c2c5::agenda_contactos {
    struct Agenda has key {
        id: 0x2::object::UID,
        propietario: address,
        contactos: 0x2::table::Table<0x2::object::ID, Contacto>,
        grupos: 0x2::table::Table<0x1::string::String, Grupo>,
        num_contactos: u64,
        capacidad_maxima: u64,
    }

    struct Contacto has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        telefono: 0x1::string::String,
        email: 0x1::string::String,
        direccion: 0x1::string::String,
        empresa: 0x1::string::String,
        notas: 0x1::string::String,
        grupo: 0x1::string::String,
        favorito: bool,
        fecha_creacion: u64,
    }

    struct Grupo has drop, store {
        nombre: 0x1::string::String,
        descripcion: 0x1::string::String,
        num_contactos: u64,
    }

    public fun actualizar_contacto(arg0: &mut Agenda, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::table::contains<0x2::object::ID, Contacto>(&arg0.contactos, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Contacto>(&mut arg0.contactos, arg1);
        v0.telefono = 0x1::string::utf8(arg2);
        v0.email = 0x1::string::utf8(arg3);
        v0.direccion = 0x1::string::utf8(arg4);
    }

    public fun agregar_contacto(arg0: &mut Agenda, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg7), 1);
        assert!(arg0.num_contactos < arg0.capacidad_maxima, 5);
        let v0 = Contacto{
            id             : 0x2::object::new(arg7),
            nombre         : 0x1::string::utf8(arg1),
            telefono       : 0x1::string::utf8(arg2),
            email          : 0x1::string::utf8(arg3),
            direccion      : 0x1::string::utf8(arg4),
            empresa        : 0x1::string::utf8(arg5),
            notas          : 0x1::string::utf8(b""),
            grupo          : 0x1::string::utf8(arg6),
            favorito       : false,
            fecha_creacion : 0,
        };
        0x2::table::add<0x2::object::ID, Contacto>(&mut arg0.contactos, 0x2::object::id<Contacto>(&v0), v0);
        arg0.num_contactos = arg0.num_contactos + 1;
    }

    public fun agregar_notas(arg0: &mut Agenda, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::table::contains<0x2::object::ID, Contacto>(&arg0.contactos, arg1), 2);
        0x2::table::borrow_mut<0x2::object::ID, Contacto>(&mut arg0.contactos, arg1).notas = 0x1::string::utf8(arg2);
    }

    public fun asignar_grupo(arg0: &mut Agenda, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::table::contains<0x2::object::ID, Contacto>(&arg0.contactos, arg1), 2);
        0x2::table::borrow_mut<0x2::object::ID, Contacto>(&mut arg0.contactos, arg1).grupo = 0x1::string::utf8(arg2);
    }

    public fun crear_agenda(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Agenda{
            id               : 0x2::object::new(arg0),
            propietario      : 0x2::tx_context::sender(arg0),
            contactos        : 0x2::table::new<0x2::object::ID, Contacto>(arg0),
            grupos           : 0x2::table::new<0x1::string::String, Grupo>(arg0),
            num_contactos    : 0,
            capacidad_maxima : 1000,
        };
        0x2::transfer::transfer<Agenda>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun crear_grupo(arg0: &mut Agenda, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::string::utf8(arg1);
        assert!(!0x2::table::contains<0x1::string::String, Grupo>(&arg0.grupos, v0), 3);
        let v1 = Grupo{
            nombre        : v0,
            descripcion   : 0x1::string::utf8(arg2),
            num_contactos : 0,
        };
        0x2::table::add<0x1::string::String, Grupo>(&mut arg0.grupos, v0, v1);
    }

    public fun eliminar_contacto(arg0: &mut Agenda, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, Contacto>(&arg0.contactos, arg1), 2);
        let Contacto {
            id             : v0,
            nombre         : _,
            telefono       : _,
            email          : _,
            direccion      : _,
            empresa        : _,
            notas          : _,
            grupo          : _,
            favorito       : _,
            fecha_creacion : _,
        } = 0x2::table::remove<0x2::object::ID, Contacto>(&mut arg0.contactos, arg1);
        0x2::object::delete(v0);
        arg0.num_contactos = arg0.num_contactos - 1;
    }

    public fun marcar_favorito(arg0: &mut Agenda, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::table::contains<0x2::object::ID, Contacto>(&arg0.contactos, arg1), 2);
        0x2::table::borrow_mut<0x2::object::ID, Contacto>(&mut arg0.contactos, arg1).favorito = arg2;
    }

    public fun obtener_total_contactos(arg0: &Agenda) : u64 {
        arg0.num_contactos
    }

    // decompiled from Move bytecode v6
}

