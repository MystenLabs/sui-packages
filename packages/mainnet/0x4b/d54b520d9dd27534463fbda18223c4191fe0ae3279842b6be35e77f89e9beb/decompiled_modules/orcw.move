module 0x4bd54b520d9dd27534463fbda18223c4191fe0ae3279842b6be35e77f89e9beb::orcw {
    struct ORCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCW>(arg0, 9, b"ORCW", b"Orc Woman", b"ORCW IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/057/967/889/large/stasia-bubnova-orc-woman-1.jpg?1673082931")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORCW>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCW>>(v1);
    }

    // decompiled from Move bytecode v6
}

