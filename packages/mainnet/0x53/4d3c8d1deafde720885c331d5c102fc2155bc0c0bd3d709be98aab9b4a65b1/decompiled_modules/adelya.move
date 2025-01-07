module 0x534d3c8d1deafde720885c331d5c102fc2155bc0c0bd3d709be98aab9b4a65b1::adelya {
    struct ADELYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADELYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADELYA>(arg0, 9, b"ADELYA", b"Adelya Girl Slut", b"ADELYA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c.nbsamara.net/sites/nbsamara.net/files/styles/width250px/public/img_6306.png?itok=9M_r7lo4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADELYA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADELYA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADELYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

