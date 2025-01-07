module 0xac3e927586f6fc7afe7b971511d1c7dd52df758f1cf0e179a7061bdb455f800f::arcer {
    struct ARCER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCER>(arg0, 9, b"ARCER", b"Arcane Enforcer", b"ARCER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/076/831/560/large/stasia-bubnova-arcane-enforcer-render-1.jpg?1717934305")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARCER>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCER>>(v1);
    }

    // decompiled from Move bytecode v6
}

