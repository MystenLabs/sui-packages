module 0xd53ddf99f9f1c41b4c98c372d11778ae1813345ceb5acb1a484a292372a71f59::prestamos_libros {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LibroNFT has store, key {
        id: 0x2::object::UID,
        titulo: vector<u8>,
        autor: vector<u8>,
    }

    struct Garantia has store {
        fondos: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Prestamo has store, key {
        id: 0x2::object::UID,
        libro_id: 0x2::object::ID,
        garantia: Garantia,
        prestatario: address,
        fecha_vencimiento: u64,
    }

    public entry fun acunar_libro(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LibroNFT{
            id     : 0x2::object::new(arg3),
            titulo : arg1,
            autor  : arg2,
        };
        0x2::transfer::public_transfer<LibroNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun prestar_libro(arg0: LibroNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Garantia{fondos: 0x2::coin::into_balance<0x2::sui::SUI>(arg1)};
        let v2 = Prestamo{
            id                : 0x2::object::new(arg3),
            libro_id          : 0x2::object::id<LibroNFT>(&arg0),
            garantia          : v1,
            prestatario       : v0,
            fecha_vencimiento : 0x2::clock::timestamp_ms(arg2) + 120000,
        };
        0x2::transfer::public_transfer<LibroNFT>(arg0, v0);
        0x2::transfer::public_transfer<Prestamo>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

