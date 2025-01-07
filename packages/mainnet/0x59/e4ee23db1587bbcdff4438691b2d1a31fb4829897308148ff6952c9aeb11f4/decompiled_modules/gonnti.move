module 0x59e4ee23db1587bbcdff4438691b2d1a31fb4829897308148ff6952c9aeb11f4::gonnti {
    struct GONNTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONNTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONNTI>(arg0, 9, b"gonnti", b"Gonnti", b"GONNTI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/739/315/large/kevan-goy-husband-portrait.jpg?1728394077")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GONNTI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONNTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONNTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

