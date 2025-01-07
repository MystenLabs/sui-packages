module 0x2d5ecccda46d1ca6aa27ff60918f131b78577185c7412070d65a0332a647b1b9::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAI>(arg0, 9, b"SAMURAI", b"The Last Samurai", b"SAMURAI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/646/268/large/han-flores-comm-for-tristan-final-jpgg.jpg?1728130749")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAMURAI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

