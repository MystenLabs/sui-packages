module 0x89479be01bb501ce6fff4fffe95f45f36aaabb4697bb25d9c20b61473db36e75::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OG>(arg0, 6, 0x1::string::utf8(b"OG"), 0x1::string::utf8(b"OG INDEX"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OG>>(0x2::coin_registry::finalize<OG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

