module 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SU>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

