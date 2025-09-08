module 0x3910b52d8f93789c17b6695230c9d8d9c00158ff6859e7968b7ebdc35f741bb0::minipos {
    struct Articulo has drop, store {
        codigo: 0x1::string::String,
        descripcion: 0x1::string::String,
        precio: u32,
        activo: bool,
    }

    struct Almacen has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        articulos: 0x2::vec_map::VecMap<u64, Articulo>,
    }

    public fun actualizar_articulo(arg0: &mut Almacen, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32) {
        assert!(0x2::vec_map::contains<u64, Articulo>(&arg0.articulos, &arg1), 13906834522235863043);
        let v0 = 0x2::vec_map::get_mut<u64, Articulo>(&mut arg0.articulos, &arg1);
        v0.codigo = arg2;
        v0.descripcion = arg3;
        v0.precio = arg4;
    }

    public fun actualizar_disponibilidad_articulo(arg0: &mut Almacen, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Articulo>(&arg0.articulos, &arg1), 13906834453516386307);
        let v0 = 0x2::vec_map::get_mut<u64, Articulo>(&mut arg0.articulos, &arg1);
        v0.activo = !v0.activo;
    }

    public fun actualizar_precio_articulo(arg0: &mut Almacen, arg1: u64, arg2: u32) {
        assert!(0x2::vec_map::contains<u64, Articulo>(&arg0.articulos, &arg1), 13906834487876124675);
        0x2::vec_map::get_mut<u64, Articulo>(&mut arg0.articulos, &arg1).precio = arg2;
    }

    public fun agregar_articulo(arg0: &mut Almacen, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32) {
        assert!(!0x2::vec_map::contains<u64, Articulo>(&arg0.articulos, &arg1), 13906834393386713089);
        let v0 = Articulo{
            codigo      : arg2,
            descripcion : arg3,
            precio      : arg4,
            activo      : true,
        };
        0x2::vec_map::insert<u64, Articulo>(&mut arg0.articulos, arg1, v0);
    }

    public fun crear_almacen(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Almacen{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            articulos : 0x2::vec_map::empty<u64, Articulo>(),
        };
        0x2::transfer::transfer<Almacen>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_almacen(arg0: Almacen) {
        let Almacen {
            id        : v0,
            nombre    : _,
            articulos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_articulo(arg0: &mut Almacen, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Articulo>(&arg0.articulos, &arg1), 13906834565185536003);
        let (_, _) = 0x2::vec_map::remove<u64, Articulo>(&mut arg0.articulos, &arg1);
    }

    // decompiled from Move bytecode v6
}

