module 0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MAIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

