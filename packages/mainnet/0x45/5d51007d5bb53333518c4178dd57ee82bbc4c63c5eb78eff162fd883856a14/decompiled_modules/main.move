module 0x455d51007d5bb53333518c4178dd57ee82bbc4c63c5eb78eff162fd883856a14::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MAIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

