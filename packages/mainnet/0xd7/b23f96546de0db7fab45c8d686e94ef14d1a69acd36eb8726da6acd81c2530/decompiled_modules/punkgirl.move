module 0xd7b23f96546de0db7fab45c8d686e94ef14d1a69acd36eb8726da6acd81c2530::punkgirl {
    struct PUNKGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKGIRL>(arg0, 9, b"punkgirl", b"Sui Punk Girl", b"PUNKGIRL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/453/075/large/stasia-bubnova-punk-girl-2.jpg?1727630912")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUNKGIRL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

