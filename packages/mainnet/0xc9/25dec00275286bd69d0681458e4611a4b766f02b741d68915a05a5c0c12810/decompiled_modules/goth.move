module 0xc925dec00275286bd69d0681458e4611a4b766f02b741d68915a05a5c0c12810::goth {
    struct GOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTH>(arg0, 9, b"GOTH", b"Techno Goth", b"GOTH IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/817/191/large/mathias-osland-gabmshsxiaat4w0.jpg?1728581013")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOTH>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

