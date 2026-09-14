module 0xe6d444ab159d1b3cd67f5af78e3e863943f50d52ca30ad3d1a884c0a00ce6db8::fartt6 {
    struct FARTT6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTT6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTT6>(arg0, 6, 0x1::string::utf8(b"FartT6"), 0x1::string::utf8(b"FartTest"), 0x1::string::utf8(b"early bond test 6"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTT6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTT6>>(0x2::coin_registry::finalize<FARTT6>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

