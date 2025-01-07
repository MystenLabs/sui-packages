module 0xeb3097639024e892430abb3464aa4b6387a86bd8555e0cee1312a6b6142062ab::tralala {
    struct TRALALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRALALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALALA>(arg0, 6, b"TRALALA", b"tralala", b"WEE WOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732435821711.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRALALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALALA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

