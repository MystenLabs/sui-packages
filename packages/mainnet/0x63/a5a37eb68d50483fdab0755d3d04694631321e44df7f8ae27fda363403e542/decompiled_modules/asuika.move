module 0x63a5a37eb68d50483fdab0755d3d04694631321e44df7f8ae27fda363403e542::asuika {
    struct ASUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIKA>(arg0, 9, b"ASUIKA", b"Asuika EVA", b"ASUIKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/076/590/437/large/fhnt-01-1.jpg?1717343730")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUIKA>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

