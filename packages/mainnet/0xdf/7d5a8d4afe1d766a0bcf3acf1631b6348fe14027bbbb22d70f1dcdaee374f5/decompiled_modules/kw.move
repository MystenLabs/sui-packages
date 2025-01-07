module 0xdf7d5a8d4afe1d766a0bcf3acf1631b6348fe14027bbbb22d70f1dcdaee374f5::kw {
    struct KW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KW>(arg0, 6, b"KW", b"GBCMOBILE", b"Providing a comprehensive digital currency based on digital currencies to support sustainable growth in the mobile phone and accessories sector, while providing innovative financial services ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968621997.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

