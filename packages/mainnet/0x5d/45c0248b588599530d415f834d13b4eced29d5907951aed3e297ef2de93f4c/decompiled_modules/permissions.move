module 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::permissions {
    struct PERMISSIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERMISSIONS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PERMISSIONS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

