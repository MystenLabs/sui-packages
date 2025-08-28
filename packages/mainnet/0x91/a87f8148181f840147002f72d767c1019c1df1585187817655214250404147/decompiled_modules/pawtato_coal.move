module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal {
    struct PAWTATO_COAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COAL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_coal(arg0: 0x2::coin::Coin<PAWTATO_COAL>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

