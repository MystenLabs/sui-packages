module 0x5b27ac313e6a33185b8e6b5ac3f3f08d45e8e9c125caac744dd04e032e4420ec::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CBS>(arg0, 6, 0x1::string::utf8(b"CBS"), 0x1::string::utf8(b"CBS bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CBS>>(0x2::coin_registry::finalize<CBS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

