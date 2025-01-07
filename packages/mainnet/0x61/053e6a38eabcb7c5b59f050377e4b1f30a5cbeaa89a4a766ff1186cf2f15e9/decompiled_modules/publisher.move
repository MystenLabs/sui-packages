module 0x61053e6a38eabcb7c5b59f050377e4b1f30a5cbeaa89a4a766ff1186cf2f15e9::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUBLISHER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

