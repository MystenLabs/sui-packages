module 0x9f41dadb335bc56697e55cd50e3d655cb57d220ab1550f9902ce815f1b4d39d6::bbb_admin {
    struct BBBAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BBB_ADMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB_ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BBBAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BBBAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

