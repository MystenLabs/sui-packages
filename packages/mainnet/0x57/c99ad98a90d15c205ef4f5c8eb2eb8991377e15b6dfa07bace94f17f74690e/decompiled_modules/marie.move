module 0x57c99ad98a90d15c205ef4f5c8eb2eb8991377e15b6dfa07bace94f17f74690e::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 9, b"marie", b"Marie Rose", b"MARIE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_0146_e8d6209e8f.jpeg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARIE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

