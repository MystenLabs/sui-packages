module 0x918b649b77bfcdb146c78679d69417f36e3781600443a4ab7b7a769e82df353f::tienda {
    struct TiendaMascotas has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        inventario: 0x2::vec_map::VecMap<0x1::string::String, Mascota>,
        owner: address,
    }

    struct Mascota has copy, drop, store {
        nombre: 0x1::string::String,
        especie: 0x1::string::String,
        edad: u8,
        disponible: bool,
    }

    public fun actualizar_disponibilidad(arg0: &mut TiendaMascotas, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        validar_owner(arg0, arg3);
        assert!(0x2::vec_map::contains<0x1::string::String, Mascota>(&arg0.inventario, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, Mascota>(&mut arg0.inventario, &arg1).disponible = arg2;
    }

    public fun agregar_mascota(arg0: &mut TiendaMascotas, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        validar_owner(arg0, arg6);
        assert!(!0x2::vec_map::contains<0x1::string::String, Mascota>(&arg0.inventario, &arg1), 1);
        let v0 = Mascota{
            nombre     : arg2,
            especie    : arg3,
            edad       : arg4,
            disponible : arg5,
        };
        0x2::vec_map::insert<0x1::string::String, Mascota>(&mut arg0.inventario, arg1, v0);
    }

    public fun crear_tienda(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String) : TiendaMascotas {
        TiendaMascotas{
            id         : 0x2::object::new(arg0),
            nombre     : arg1,
            inventario : 0x2::vec_map::empty<0x1::string::String, Mascota>(),
            owner      : 0x2::tx_context::sender(arg0),
        }
    }

    public fun eliminar_mascota(arg0: &mut TiendaMascotas, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        validar_owner(arg0, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, Mascota>(&arg0.inventario, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, Mascota>(&mut arg0.inventario, &arg1);
    }

    public fun obtener_mascota(arg0: &TiendaMascotas, arg1: 0x1::string::String) : Mascota {
        assert!(0x2::vec_map::contains<0x1::string::String, Mascota>(&arg0.inventario, &arg1), 2);
        *0x2::vec_map::get<0x1::string::String, Mascota>(&arg0.inventario, &arg1)
    }

    public fun registrar_tienda(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = crear_tienda(arg1, arg0);
        0x2::transfer::transfer<TiendaMascotas>(v0, 0x2::tx_context::sender(arg1));
    }

    fun validar_owner(arg0: &TiendaMascotas, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
    }

    // decompiled from Move bytecode v6
}

