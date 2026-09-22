module 0xdab03c0a5c1e939fda1a708ecdd384c9ea487bf0e0be333b1ea9d2ce34dad528::t3 {
    struct T3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T3>(arg0, 6, 0x1::string::utf8(b"T3"), 0x1::string::utf8(b"t3Test"), 0x1::string::utf8(b"testing fartpad t3 mode"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/dd366d0b06b0ead89b10f6ca5f9b1876a3f736855be9e3a8d520d2b6629bd388?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T3>>(0x2::coin_registry::finalize<T3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

