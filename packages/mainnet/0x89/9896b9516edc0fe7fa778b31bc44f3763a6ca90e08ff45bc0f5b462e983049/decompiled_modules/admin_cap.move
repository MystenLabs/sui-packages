module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::admin_cap {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN_CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADMIN_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

