module 0xe407817a002248b1cd877f55294321dbe3b3d266c3a2036e3960ea235672ee8a::equipos {
    struct ISBN has copy, drop, store {
        value: u16,
    }

    struct Modelo has copy, drop, store {
        optiplex: 0x1::string::String,
        serie: 0x1::string::String,
        fabricado: u16,
        stock: bool,
    }

    struct Inventario has key {
        id: 0x2::object::UID,
        marca: 0x1::string::String,
        modelos: 0x2::vec_map::VecMap<ISBN, Modelo>,
    }

    public fun actualizar_stock(arg0: ISBN, arg1: &mut Inventario) {
        let v0 = 0x2::vec_map::get_mut<ISBN, Modelo>(&mut arg1.modelos, &arg0);
        v0.stock = !v0.stock;
    }

    public fun agregar_modelo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u16, arg3: ISBN, arg4: &mut Inventario) {
        let v0 = Modelo{
            optiplex  : arg0,
            serie     : arg1,
            fabricado : arg2,
            stock     : true,
        };
        0x2::vec_map::insert<ISBN, Modelo>(&mut arg4.modelos, arg3, v0);
    }

    public fun crear_inventario(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Inventario{
            id      : 0x2::object::new(arg1),
            marca   : arg0,
            modelos : 0x2::vec_map::empty<ISBN, Modelo>(),
        };
        0x2::transfer::transfer<Inventario>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun editar_fabricado(arg0: ISBN, arg1: u16, arg2: &mut Inventario) {
        0x2::vec_map::get_mut<ISBN, Modelo>(&mut arg2.modelos, &arg0).fabricado = arg1;
    }

    public fun editar_optiplex(arg0: ISBN, arg1: 0x1::string::String, arg2: &mut Inventario) {
        0x2::vec_map::get_mut<ISBN, Modelo>(&mut arg2.modelos, &arg0).optiplex = arg1;
    }

    public fun editar_serie(arg0: ISBN, arg1: 0x1::string::String, arg2: &mut Inventario) {
        0x2::vec_map::get_mut<ISBN, Modelo>(&mut arg2.modelos, &arg0).serie = arg1;
    }

    public fun eliminar_inventario(arg0: Inventario) {
        let Inventario {
            id      : v0,
            marca   : _,
            modelos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_modelo(arg0: ISBN, arg1: &mut Inventario) {
        let (_, _) = 0x2::vec_map::remove<ISBN, Modelo>(&mut arg1.modelos, &arg0);
    }

    // decompiled from Move bytecode v6
}

