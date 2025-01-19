module 0x111a2cf1866498a5fa26f6914f718f22595a559648f2fb42db9e603ee4813aeb::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"Official Elon Coin by SuiAI", b"One and only. ELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0095_8a05e53ef6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

