module 0xb52fe3e0e5f5523c19ca2f2e529f6da5a81bc08045019b4cfcd11347015b3346::borc {
    struct BORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORC>(arg0, 9, b"BORC", b"Broken Orc", b"BORC IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/888/328/large/cody-alday-breakdown-orc-portrait-c.jpg?1728821325")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BORC>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORC>>(v1);
    }

    // decompiled from Move bytecode v6
}

