module 0xef8e3455f41a7485f7afa6409c2216071160a247b1198a55382151f9ed2a4d5::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MAIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

