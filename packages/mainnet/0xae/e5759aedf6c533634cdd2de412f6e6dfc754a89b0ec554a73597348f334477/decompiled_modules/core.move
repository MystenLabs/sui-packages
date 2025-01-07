module 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

