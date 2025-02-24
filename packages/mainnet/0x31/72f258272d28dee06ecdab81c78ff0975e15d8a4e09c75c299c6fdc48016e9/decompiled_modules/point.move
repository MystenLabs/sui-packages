module 0xf8ee6671c195bb61ee5effbccb2c4fdf6492c7395d16f498c142468d38ad9e54::point {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

