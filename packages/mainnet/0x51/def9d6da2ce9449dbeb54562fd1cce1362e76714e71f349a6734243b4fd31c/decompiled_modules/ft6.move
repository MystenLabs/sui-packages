module 0x51def9d6da2ce9449dbeb54562fd1cce1362e76714e71f349a6734243b4fd31c::ft6 {
    struct FT6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FT6>(arg0, 6, 0x1::string::utf8(b"ft6"), 0x1::string::utf8(b"ftest6"), 0x1::string::utf8(b"testt"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/vXbA_sj8gvXngQhV?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FT6>>(0x2::coin_registry::finalize<FT6>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

