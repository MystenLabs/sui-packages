module 0x4e3cc8ab65da9df512f85ca240d5dc933581cc68da091ba6e931cd02f609c40b::tienda {
    struct Camisa has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        precio: u64,
        stock: u8,
        disponible: bool,
        talla: 0x1::string::String,
        color: 0x1::string::String,
    }

    struct Pantalon has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        precio: u64,
        stock: u8,
        disponible: bool,
        largo: u8,
        tipo: 0x1::string::String,
    }

    public entry fun actualizar_precio_camisa(arg0: &mut Camisa, arg1: u64) {
        arg0.precio = arg1;
    }

    public entry fun actualizar_stock_camisa(arg0: &mut Camisa, arg1: u8) {
        arg0.stock = arg1;
    }

    public fun aplicar_descuento(arg0: u64, arg1: u8) : u64 {
        arg0 - arg0 * (arg1 as u64) / 100
    }

    public fun comparar_precios(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun crear_camisa(arg0: 0x1::string::String, arg1: u64, arg2: u8, arg3: bool, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Camisa{
            id         : 0x2::object::new(arg6),
            nombre     : arg0,
            precio     : arg1,
            stock      : arg2,
            disponible : arg3,
            talla      : arg4,
            color      : arg5,
        };
        0x2::transfer::transfer<Camisa>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun crear_pantalon(arg0: 0x1::string::String, arg1: u64, arg2: u8, arg3: bool, arg4: u8, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Pantalon{
            id         : 0x2::object::new(arg6),
            nombre     : arg0,
            precio     : arg1,
            stock      : arg2,
            disponible : arg3,
            largo      : arg4,
            tipo       : arg5,
        };
        0x2::transfer::transfer<Pantalon>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun duplicar_camisa(arg0: &Camisa, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Camisa{
            id         : 0x2::object::new(arg1),
            nombre     : arg0.nombre,
            precio     : arg0.precio,
            stock      : arg0.stock,
            disponible : arg0.disponible,
            talla      : arg0.talla,
            color      : arg0.color,
        };
        0x2::transfer::transfer<Camisa>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun generar_descripcion(arg0: &Camisa) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Camisa: ");
        0x1::string::append(&mut v0, arg0.nombre);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" - Talla "));
        0x1::string::append(&mut v0, arg0.talla);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" - Color "));
        0x1::string::append(&mut v0, arg0.color);
        v0
    }

    public fun hay_stock(arg0: u8) : bool {
        arg0 > 0
    }

    public entry fun marcar_no_disponible(arg0: &mut Camisa) {
        arg0.disponible = false;
    }

    public fun mostrar_camisa(arg0: &Camisa) {
        0x1::debug::print<0x1::string::String>(&arg0.nombre);
        0x1::debug::print<u64>(&arg0.precio);
        0x1::debug::print<u8>(&arg0.stock);
        0x1::debug::print<bool>(&arg0.disponible);
        0x1::debug::print<0x1::string::String>(&arg0.talla);
        0x1::debug::print<0x1::string::String>(&arg0.color);
    }

    public fun mostrar_pantalon(arg0: &Pantalon) {
        0x1::debug::print<0x1::string::String>(&arg0.nombre);
        0x1::debug::print<u64>(&arg0.precio);
        0x1::debug::print<u8>(&arg0.stock);
        0x1::debug::print<bool>(&arg0.disponible);
        0x1::debug::print<u8>(&arg0.largo);
        0x1::debug::print<0x1::string::String>(&arg0.tipo);
    }

    public entry fun transferir_camisa(arg0: Camisa, arg1: address) {
        0x2::transfer::transfer<Camisa>(arg0, arg1);
    }

    public entry fun transferir_pantalon(arg0: Pantalon, arg1: address) {
        0x2::transfer::transfer<Pantalon>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

