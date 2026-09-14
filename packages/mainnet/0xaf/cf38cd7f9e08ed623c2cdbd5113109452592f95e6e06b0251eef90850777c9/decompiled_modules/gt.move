module 0xafcf38cd7f9e08ed623c2cdbd5113109452592f95e6e06b0251eef90850777c9::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GT>(arg0, 6, 0x1::string::utf8(b"GT"), 0x1::string::utf8(b"GoldTest"), 0x1::string::utf8(b"Testing gold pair on fartpad"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GT>>(0x2::coin_registry::finalize<GT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

