module 0x355c2d4ed79cf0f40a0fb339d499134038465abccd854be31597e7a3e4a8acf6::s50 {
    struct S50 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S50, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S50>(arg0, 6, b"S50", b"50 sui", b"It's time to get rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/preview_c4339750d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S50>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S50>>(v1);
    }

    // decompiled from Move bytecode v6
}

