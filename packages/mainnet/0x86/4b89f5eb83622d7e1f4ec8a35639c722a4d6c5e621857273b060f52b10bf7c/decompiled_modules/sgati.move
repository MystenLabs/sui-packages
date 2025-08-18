module 0x864b89f5eb83622d7e1f4ec8a35639c722a4d6c5e621857273b060f52b10bf7c::sgati {
    struct SgatiAdminCap has key {
        id: 0x2::object::UID,
    }

    struct RegistroMantenimiento has drop, store {
        tipo_mantenimiento: 0x1::string::String,
        descripcion: 0x1::string::String,
        tecnico: 0x1::string::String,
        fecha: u64,
    }

    struct Activo has store, key {
        id: 0x2::object::UID,
        tipo_activo: 0x1::string::String,
        modelo: 0x1::string::String,
        numero_serie: 0x1::string::String,
        fecha_registro: u64,
        ubicacion: 0x1::string::String,
        asignado_a: 0x1::option::Option<0x1::string::String>,
        estado: 0x1::string::String,
        registros_mantenimiento: vector<RegistroMantenimiento>,
        propietario: address,
    }

    public fun asignar_activo(arg0: &mut Activo, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(arg0.estado == 0x1::string::utf8(b"en_almacen"), 1);
        assert!(arg0.estado != 0x1::string::utf8(b"retirado"), 2);
        arg0.ubicacion = arg2;
        arg0.asignado_a = 0x1::option::some<0x1::string::String>(arg1);
        arg0.estado = 0x1::string::utf8(b"asignado");
    }

    public fun crear_activo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext, arg5: &0x2::clock::Clock) {
        let v0 = Activo{
            id                      : 0x2::object::new(arg4),
            tipo_activo             : arg0,
            modelo                  : arg1,
            numero_serie            : arg2,
            fecha_registro          : 0x2::clock::timestamp_ms(arg5),
            ubicacion               : arg3,
            asignado_a              : 0x1::option::none<0x1::string::String>(),
            estado                  : 0x1::string::utf8(b"en_almacen"),
            registros_mantenimiento : 0x1::vector::empty<RegistroMantenimiento>(),
            propietario             : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::transfer<Activo>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun enviar_a_mantenimiento(arg0: &mut Activo, arg1: 0x1::string::String) {
        assert!(arg0.estado != 0x1::string::utf8(b"retirado"), 2);
        arg0.ubicacion = arg1;
        arg0.asignado_a = 0x1::option::none<0x1::string::String>();
        arg0.estado = 0x1::string::utf8(b"en_mantenimiento");
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SgatiAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SgatiAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun registrar_mantenimiento_realizado(arg0: &mut Activo, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        assert!(arg0.estado == 0x1::string::utf8(b"en_mantenimiento"), 3);
        let v0 = RegistroMantenimiento{
            tipo_mantenimiento : arg1,
            descripcion        : arg2,
            tecnico            : arg3,
            fecha              : 0x2::clock::timestamp_ms(arg5),
        };
        0x1::vector::push_back<RegistroMantenimiento>(&mut arg0.registros_mantenimiento, v0);
        arg0.ubicacion = arg4;
        arg0.estado = 0x1::string::utf8(b"en_almacen");
    }

    public fun retirar_activo(arg0: &mut Activo) {
        assert!(arg0.estado != 0x1::string::utf8(b"retirado"), 2);
        arg0.estado = 0x1::string::utf8(b"retirado");
        arg0.asignado_a = 0x1::option::none<0x1::string::String>();
    }

    // decompiled from Move bytecode v6
}

