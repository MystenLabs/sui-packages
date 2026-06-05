module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap {
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

    // decompiled from Move bytecode v6
}

