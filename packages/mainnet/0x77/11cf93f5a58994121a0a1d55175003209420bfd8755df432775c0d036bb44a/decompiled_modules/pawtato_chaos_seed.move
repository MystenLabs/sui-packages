module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed {
    struct PAWTATO_CHAOS_SEED has drop {
        dummy_field: bool,
    }

    public fun transfer_chaos_seed(arg0: 0x2::coin::Coin<PAWTATO_CHAOS_SEED>, arg1: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

