module 0xdf6c689726d20a3e8935df51afacb5f9e43c736afe700bab58ad8e398307733f::mika {
    struct MIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA>(arg0, 6, b"Mika", b"Mika (zerebro gf)", b"Trending Mika on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731810916978.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

