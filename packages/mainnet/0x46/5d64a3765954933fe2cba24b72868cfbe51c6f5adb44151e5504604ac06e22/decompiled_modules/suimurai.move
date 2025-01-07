module 0x465d64a3765954933fe2cba24b72868cfbe51c6f5adb44151e5504604ac06e22::suimurai {
    struct SUIMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAI>(arg0, 9, b"SUIMURAI", b"The Last Sui Samurai", b"SUIMURAI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/646/268/large/han-flores-comm-for-tristan-final-jpgg.jpg?1728130749")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMURAI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

