module 0xabf187fe86408e5eb89001d44947dbb55ee727a9da340631a15a7611bec28b78::jitter_point {
    struct JITTER_POINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JITTER_POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JITTER_POINT>(arg0, 6, 0x1::string::utf8(b"JPOINT"), 0x1::string::utf8(b"Jitter Point"), 0x1::string::utf8(b"Tokenized Jitter points for Liquidlink point trading"), 0x1::string::utf8(b"https://raw.githubusercontent.com/sui-foundation/sui-icons/main/sui-icon.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JITTER_POINT>>(0x2::coin_registry::finalize<JITTER_POINT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JITTER_POINT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

