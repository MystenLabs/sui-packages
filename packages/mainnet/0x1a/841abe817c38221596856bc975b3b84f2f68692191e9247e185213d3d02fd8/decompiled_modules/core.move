module 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

