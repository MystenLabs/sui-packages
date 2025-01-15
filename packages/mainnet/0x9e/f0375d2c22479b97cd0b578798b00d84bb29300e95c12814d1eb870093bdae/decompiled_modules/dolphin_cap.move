module 0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::dolphin_cap {
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

