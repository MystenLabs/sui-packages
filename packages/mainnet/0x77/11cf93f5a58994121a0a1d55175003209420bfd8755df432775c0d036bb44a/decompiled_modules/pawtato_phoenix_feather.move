module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather {
    struct PAWTATO_PHOENIX_FEATHER has drop {
        dummy_field: bool,
    }

    public fun transfer_phoenix_feather(arg0: 0x2::coin::Coin<PAWTATO_PHOENIX_FEATHER>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

