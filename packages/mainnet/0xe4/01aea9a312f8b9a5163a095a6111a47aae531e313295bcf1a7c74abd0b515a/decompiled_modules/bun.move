module 0xe401aea9a312f8b9a5163a095a6111a47aae531e313295bcf1a7c74abd0b515a::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BUN>(arg0, 6, 0x1::string::utf8(b"BUN"), 0x1::string::utf8(b"BUN bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BUN>>(0x2::coin_registry::finalize<BUN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

