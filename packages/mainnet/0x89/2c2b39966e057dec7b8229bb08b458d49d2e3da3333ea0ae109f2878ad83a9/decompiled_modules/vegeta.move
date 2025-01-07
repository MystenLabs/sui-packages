module 0x892c2b39966e057dec7b8229bb08b458d49d2e3da3333ea0ae109f2878ad83a9::vegeta {
    struct VEGETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEGETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEGETA>(arg0, 9, b"VEGETA", b"Vegeta", b"VEGETA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/840/680/large/vineet-kumar-04.jpg?1728653325")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VEGETA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEGETA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEGETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

