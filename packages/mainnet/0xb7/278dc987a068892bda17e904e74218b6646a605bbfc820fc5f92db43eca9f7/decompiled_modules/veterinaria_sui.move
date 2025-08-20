module 0xb7278dc987a068892bda17e904e74218b6646a605bbfc820fc5f92db43eca9f7::veterinaria_sui {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Producto has store, key {
        id: 0x2::object::UID,
        nombre: vector<u8>,
        descripcion: vector<u8>,
        precio: u64,
    }

    struct Cita has store, key {
        id: 0x2::object::UID,
        nombre_paciente: vector<u8>,
        fecha_cita_ms: u64,
        cliente: address,
        deposito: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun agendar_cita(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 500000000, 2);
        let v0 = Cita{
            id              : 0x2::object::new(arg4),
            nombre_paciente : arg0,
            fecha_cita_ms   : arg1,
            cliente         : 0x2::tx_context::sender(arg4),
            deposito        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
        };
        0x2::transfer::public_transfer<Cita>(v0, 0x2::tx_context::sender(arg4));
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

    public entry fun comprar_producto(arg0: Producto, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.precio, 1);
        0x2::transfer::public_transfer<Producto>(arg0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

