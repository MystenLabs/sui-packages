module 0x3a5a0876476e6e93d9e8c77fc763f295274f73ea651f10eaa64979eb093ee17b::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

