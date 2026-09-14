module 0xf34f03abf4013de0927bebf7153c5785b791b66f24629dd2783bbe420d1860bc::ft2 {
    struct FT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FT2>(arg0, 6, 0x1::string::utf8(b"FT2"), 0x1::string::utf8(b"FartTest2"), 0x1::string::utf8(b"Testing fartpad test2"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FT2>>(0x2::coin_registry::finalize<FT2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

