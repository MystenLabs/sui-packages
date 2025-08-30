module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron {
    struct PAWTATO_IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_IRON, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_iron(arg0: 0x2::coin::Coin<PAWTATO_IRON>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

