module 0xbcce7bcb39a7718ff69ead98a4ae367f68699b119d5056b71e9a1b244ac1e79d::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SUIDROP", b"suidrop", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

