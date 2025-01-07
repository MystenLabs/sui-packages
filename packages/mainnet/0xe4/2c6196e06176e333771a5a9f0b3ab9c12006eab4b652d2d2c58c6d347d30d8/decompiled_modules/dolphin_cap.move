module 0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::dolphin_cap {
    struct DolphinCap has store, key {
        id: 0x2::object::UID,
    }

    struct DOLPHIN_CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DolphinCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<DolphinCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

