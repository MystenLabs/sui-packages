module 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::frozen_pub {
    struct FROZEN_PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN_PUB, arg1: &mut 0x2::tx_context::TxContext) {
        0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::frozen_publisher::freeze_from_otw<FROZEN_PUB>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

