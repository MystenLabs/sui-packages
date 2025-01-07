module 0xe2864a0b814e9515f8798cdfbc48cb22813ed320e524ec6b015b5a288e7cc359::jetpacker {
    struct JETPACKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETPACKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETPACKER>(arg0, 9, b"JETPACKER", b"Snipe Jetpacker", b"JETPACKER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/078/283/502/large/popularity_choi-1.jpg?1721698322")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JETPACKER>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETPACKER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JETPACKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

