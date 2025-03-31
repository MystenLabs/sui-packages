module 0xa264781b1faea3f7c02d6d5590b719e6169243450a316c0d698679a1a9ef72ff::blacky {
    struct BLACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKY>(arg0, 6, b"BLACKY", b"$BLACKY", b"Goooo by crypto monsters collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CRYPTO_MONSTERS_COLLECITION_11_8c939bc59b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

