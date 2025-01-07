module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    public fun version() : u16 {
        1
    }

    // decompiled from Move bytecode v6
}

