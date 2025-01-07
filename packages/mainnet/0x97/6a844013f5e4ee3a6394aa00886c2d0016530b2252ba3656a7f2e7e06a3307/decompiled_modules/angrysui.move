module 0x976a844013f5e4ee3a6394aa00886c2d0016530b2252ba3656a7f2e7e06a3307::angrysui {
    struct ANGRYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYSUI>(arg0, 9, b"ANGRYsui", b"Angry Birds Sui", b"ANGRYSUI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_20241013_215744_871_c9d4436731.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANGRYSUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

