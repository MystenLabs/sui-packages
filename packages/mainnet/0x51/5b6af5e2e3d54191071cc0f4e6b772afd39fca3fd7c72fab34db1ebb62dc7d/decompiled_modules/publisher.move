module 0x236149824ea2baf4e948438cab557be8ed99839bd0ebe2b07c8b43ba3310e61f::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUBLISHER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

