module 0x9dfd08b9505460dbac45d7e68bc6c802b1b26d316e30d672392d53fd3b09e6b7::tienda {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CajaRegistradora has store, key {
        id: 0x2::object::UID,
        fondos: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Producto has store, key {
        id: 0x2::object::UID,
        nombre: vector<u8>,
        descripcion: vector<u8>,
        precio: u64,
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

    public entry fun comprar_producto(arg0: Producto, arg1: &mut CajaRegistradora, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.precio, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fondos, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::transfer::public_transfer<Producto>(arg0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CajaRegistradora{
            id     : 0x2::object::new(arg0),
            fondos : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CajaRegistradora>(v1);
    }

    public entry fun retirar_fondos(arg0: &AdminCap, arg1: &mut CajaRegistradora, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fondos);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

