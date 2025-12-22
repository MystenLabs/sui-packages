module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water {
    struct PAWTATO_WATER has drop {
        dummy_field: bool,
    }

    public fun transfer_water(arg0: 0x2::coin::Coin<PAWTATO_WATER>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

