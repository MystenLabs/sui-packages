module 0xf1885a361d9fada66b49e942e554d2e6827a53e7ad9ebee6335512996fee2ad8::ft5 {
    struct FT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FT5>(arg0, 6, 0x1::string::utf8(b"ft5"), 0x1::string::utf8(b"farttest5"), 0x1::string::utf8(b"testing fartpad with early bond"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT5>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FT5>>(0x2::coin_registry::finalize<FT5>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

