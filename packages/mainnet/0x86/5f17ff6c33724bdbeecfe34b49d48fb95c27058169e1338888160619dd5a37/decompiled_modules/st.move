module 0x865f17ff6c33724bdbeecfe34b49d48fb95c27058169e1338888160619dd5a37::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ST>(arg0, 6, 0x1::string::utf8(b"ST"), 0x1::string::utf8(b"Silver Test"), 0x1::string::utf8(b"Silvertest fartpad"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ST>>(0x2::coin_registry::finalize<ST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

