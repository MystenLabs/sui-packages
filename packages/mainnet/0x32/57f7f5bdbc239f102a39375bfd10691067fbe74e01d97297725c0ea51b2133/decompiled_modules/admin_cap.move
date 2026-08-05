module 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::admin_cap {
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

