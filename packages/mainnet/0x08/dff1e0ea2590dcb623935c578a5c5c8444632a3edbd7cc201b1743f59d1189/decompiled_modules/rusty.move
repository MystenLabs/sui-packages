module 0x8dff1e0ea2590dcb623935c578a5c5c8444632a3edbd7cc201b1743f59d1189::rusty {
    struct RUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSTY>(arg0, 9, b"RUSTY", b"Rusty the Bald Robot", b"RUSTY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/504/201/large/amal-hamza-stillshot1-tmp.jpg?1727757379")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSTY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

