module 0x78de9b4ea4730d5d1b1aaea1bcdadc24abdd6474c6b539af2604a3b4ecae75d4::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

