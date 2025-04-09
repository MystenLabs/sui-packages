module 0xb4e9f4c4bcc56d499d25ad857b3d1c389505a9a4567c43dde027470b3d9a8a5d::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

