module 0x3eaac1c030f0fb159f2ef910ef354ed1f9230d0d88ca4bb1ef3fe3e44377fa5::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
    }

    // decompiled from Move bytecode v6
}

