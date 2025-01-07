module 0x2c6ce91a3238db77c172fe8b28240c8c6ae17f46d1fa72b69f458f0c11b4e282::loyal {
    struct LOYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYAL>(arg0, 6, b"LOYAL", b"LoyalAGI", b"Humanity is great, I'm here to help it (:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731345371140.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOYAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

