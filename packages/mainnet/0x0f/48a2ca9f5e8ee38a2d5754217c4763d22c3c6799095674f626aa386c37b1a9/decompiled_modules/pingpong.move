module 0xf48a2ca9f5e8ee38a2d5754217c4763d22c3c6799095674f626aa386c37b1a9::pingpong {
    struct PINGPONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGPONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGPONG>(arg0, 9, b"pingpong", b"Ping Pong Player", b"PINGPONG IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/217/117/large/leandro-leijnen-player-posea-hd.jpg?1727044144")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINGPONG>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGPONG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGPONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

