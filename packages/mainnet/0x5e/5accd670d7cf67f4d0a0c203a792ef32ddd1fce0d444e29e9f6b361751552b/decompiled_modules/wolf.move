module 0x5e5accd670d7cf67f4d0a0c203a792ef32ddd1fce0d444e29e9f6b361751552b::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"Wolfius Maximus", b"Wolfius Maximus is all about the power and instincts of Solstreets strongest wolves. Its not just a meme coinits for those who are smart, strong, and ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_02_59_09_1d69483493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

