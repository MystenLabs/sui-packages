module 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_admin {
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

