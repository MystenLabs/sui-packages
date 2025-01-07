module 0x527c752cfa584d89560f264c881b02408da2eb244d4b637579c8a90e881d995d::suibugmoneybag {
    struct SUIBUGMONEYBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUGMONEYBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUGMONEYBAG>(arg0, 9, b"SUIbugMONEYbag", b"Sci-Fi BugMoneyBag", b"SUIBUGMONEYBAG IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/895/035/large/shumilov-artem-skin5.jpg?1728838438")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBUGMONEYBAG>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUGMONEYBAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUGMONEYBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

