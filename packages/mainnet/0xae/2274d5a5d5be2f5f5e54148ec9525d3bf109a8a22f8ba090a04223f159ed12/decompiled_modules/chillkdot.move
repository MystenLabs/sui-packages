module 0xae2274d5a5d5be2f5f5e54148ec9525d3bf109a8a22f8ba090a04223f159ed12::chillkdot {
    struct CHILLKDOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLKDOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLKDOT>(arg0, 6, b"ChillKDot", b"Chill Kdot", b"KDot is Just Chilln! Leave him alone before he turns you into a song!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chill_K_Dot_3f7ff49e02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLKDOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLKDOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

