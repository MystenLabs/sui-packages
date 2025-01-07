module 0x278ad923078281178b8b79d7c57417e2cb0db7a499533b09aa895e93fd4362f9::run_legends {
    struct RUN_LEGENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN_LEGENDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RUN_LEGENDS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

