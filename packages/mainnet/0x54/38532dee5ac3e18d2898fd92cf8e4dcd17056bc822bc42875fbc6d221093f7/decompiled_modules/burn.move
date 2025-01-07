module 0x5438532dee5ac3e18d2898fd92cf8e4dcd17056bc822bc42875fbc6d221093f7::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    public entry fun freeze_object<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<T0>(arg0);
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BURN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

