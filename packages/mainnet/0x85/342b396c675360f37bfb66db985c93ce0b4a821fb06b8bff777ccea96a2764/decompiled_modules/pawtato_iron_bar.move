module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar {
    struct PAWTATO_IRON_BAR has drop {
        dummy_field: bool,
    }

    public fun transfer_iron_bar(arg0: 0x2::coin::Coin<PAWTATO_IRON_BAR>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

