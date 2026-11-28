module 0x6500ab67776bce435d452bcf980a271dd985937dfb58ccedaa13fc4a571ee13c::grvt {
    struct GRVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRVT>(arg0, 9, b"GRVT", b"GRVT", b"GRVT token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRVT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRVT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

