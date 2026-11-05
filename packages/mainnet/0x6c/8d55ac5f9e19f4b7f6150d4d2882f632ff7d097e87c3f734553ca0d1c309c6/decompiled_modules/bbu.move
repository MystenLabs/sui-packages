module 0x6c8d55ac5f9e19f4b7f6150d4d2882f632ff7d097e87c3f734553ca0d1c309c6::bbu {
    struct BBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BBU>(arg0, 6, 0x1::string::utf8(b"BBU"), 0x1::string::utf8(b"BBU bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BBU>>(0x2::coin_registry::finalize<BBU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

