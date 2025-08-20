module 0xd78a0bffc9f5aa4ecd3d6b7a2b03a1d750280181acd12da84b9bed72539b5de4::dulceria {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Producto has store, key {
        id: 0x2::object::UID,
        nombre: vector<u8>,
        descripcion: vector<u8>,
        precio: u64,
    }

    struct Pedido has store, key {
        id: 0x2::object::UID,
        producto_id: 0x2::object::ID,
        nombre_producto: vector<u8>,
        pago: 0x2::balance::Balance<0x2::sui::SUI>,
        comprador: address,
    }

    public entry fun agregar_producto(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Producto{
            id          : 0x2::object::new(arg4),
            nombre      : arg1,
            descripcion : arg2,
            precio      : arg3,
        };
        0x2::transfer::public_transfer<Producto>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun comprar_producto(arg0: Producto, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.precio, 1);
        0x2::transfer::public_transfer<Producto>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun realizar_pedido(arg0: Producto, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.precio, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Pedido{
            id              : 0x2::object::new(arg2),
            producto_id     : 0x2::object::id<Producto>(&arg0),
            nombre_producto : arg0.nombre,
            pago            : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            comprador       : v0,
        };
        0x2::transfer::public_transfer<Pedido>(v1, v0);
        let Producto {
            id          : v2,
            nombre      : _,
            descripcion : _,
            precio      : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

