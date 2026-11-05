module 0x33a59fe7806355423fde0dfcd1a8a1cb88781b761f526d1cb1eb27ceb922c646::brf {
    struct BRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRF>(arg0, 6, 0x1::string::utf8(b"BRF"), 0x1::string::utf8(b"BRF bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRF>>(0x2::coin_registry::finalize<BRF>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

