module 0xb041e44fdd5534c8afb59595435b58899244cce48556b58750e851e660a716cc::days {
    struct DAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAYS>(arg0, 6, b"DAYS", b"Sakamoto Days", b"Once a legendary hitman feared throughout the underworld, Sakamoto retires after falling in love, settling down to run a convenience store with his family. Despite gaining weight and adopting a peaceful life, he retains his incredible combat skills and sharp instincts. When threats from his past resurface, Sakamoto must defend his loved ones while trying to uphold his no-kill policy. His character blends humor, action, and heart, making him a standout figure in the series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1461_7ab43f6ab8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

