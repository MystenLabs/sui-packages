module 0x957339383d1dfdaa9c41e63bf515a502817c040250609991b4892e8d44af7d5::cafeteria {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Producto has store, key {
        id: 0x2::object::UID,
        nombre: vector<u8>,
        descripcion: vector<u8>,
        precio: u64,
        admin: address,
    }

    struct Recibo has store, key {
        id: 0x2::object::UID,
        nombre_producto: vector<u8>,
        monto_pagado: u64,
        comprador: address,
    }

    public entry fun agregar_producto(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Producto{
            id          : 0x2::object::new(arg4),
            nombre      : arg1,
            descripcion : arg2,
            precio      : arg3,
            admin       : v0,
        };
        0x2::transfer::public_transfer<Producto>(v1, v0);
    }

    public entry fun comprar_producto(arg0: Producto, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.precio, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.precio;
        0x2::transfer::public_transfer<Producto>(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2), arg0.admin);
        let v2 = Recibo{
            id              : 0x2::object::new(arg2),
            nombre_producto : arg0.nombre,
            monto_pagado    : v1,
            comprador       : v0,
        };
        0x2::transfer::public_transfer<Recibo>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

