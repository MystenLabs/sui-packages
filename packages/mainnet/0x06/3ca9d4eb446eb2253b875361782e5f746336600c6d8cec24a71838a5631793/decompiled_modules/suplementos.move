module 0x63ca9d4eb446eb2253b875361782e5f746336600c6d8cec24a71838a5631793::suplementos {
    struct Tienda has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        contacto: 0x1::string::String,
        suplementos: 0x2::vec_map::VecMap<u8, Suplemento>,
    }

    struct Suplemento has copy, drop, store {
        nombre: 0x1::string::String,
        categoria: 0x1::string::String,
        precio: u64,
        disponible: bool,
    }

    public fun actualizar_disponibilidad(arg0: &mut Tienda, arg1: u8, arg2: bool) {
        assert!(0x2::vec_map::contains<u8, Suplemento>(&arg0.suplementos, &arg1), 2);
        0x2::vec_map::get_mut<u8, Suplemento>(&mut arg0.suplementos, &arg1).disponible = arg2;
    }

    public fun contar_suplementos(arg0: &Tienda) : u64 {
        (0x2::vec_map::length<u8, Suplemento>(&arg0.suplementos) as u64)
    }

    public fun crear_tienda(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda{
            id          : 0x2::object::new(arg2),
            nombre      : arg0,
            contacto    : arg1,
            suplementos : 0x2::vec_map::empty<u8, Suplemento>(),
        };
        0x2::transfer::transfer<Tienda>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun eliminar_suplemento(arg0: &mut Tienda, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Suplemento>(&arg0.suplementos, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u8, Suplemento>(&mut arg0.suplementos, &arg1);
    }

    public fun eliminar_tienda(arg0: Tienda) {
        let Tienda {
            id          : v0,
            nombre      : _,
            contacto    : _,
            suplementos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun obtener_info_suplemento(arg0: &Tienda, arg1: u8) : Suplemento {
        assert!(0x2::vec_map::contains<u8, Suplemento>(&arg0.suplementos, &arg1), 2);
        *0x2::vec_map::get<u8, Suplemento>(&arg0.suplementos, &arg1)
    }

    public fun registrar_suplemento(arg0: &mut Tienda, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: bool) {
        assert!(!0x2::vec_map::contains<u8, Suplemento>(&arg0.suplementos, &arg1), 1);
        let v0 = Suplemento{
            nombre     : arg2,
            categoria  : arg3,
            precio     : arg4,
            disponible : arg5,
        };
        0x2::vec_map::insert<u8, Suplemento>(&mut arg0.suplementos, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

