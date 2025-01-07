module 0xedd5a716fc7a7cdd829af4e0af9151705831453a031fe83d83e52cbe0b3dbe8b::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

