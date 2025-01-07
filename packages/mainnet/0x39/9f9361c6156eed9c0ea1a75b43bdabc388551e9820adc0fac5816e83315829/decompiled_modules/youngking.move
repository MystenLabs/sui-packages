module 0x399f9361c6156eed9c0ea1a75b43bdabc388551e9820adc0fac5816e83315829::youngking {
    struct YOUNGKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUNGKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUNGKING>(arg0, 9, b"youngking", b"Young King", b"YOUNGKING IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/814/853/large/demiurge-ash-here-is-your-crown.jpg?1728576298")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOUNGKING>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUNGKING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOUNGKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

