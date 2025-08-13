module 0x431d9b0a95671eb9cf0f356b0d36d456b502449a9cb4f054a256346c917b97e1::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

