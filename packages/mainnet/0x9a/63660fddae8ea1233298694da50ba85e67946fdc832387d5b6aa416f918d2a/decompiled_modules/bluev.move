module 0x9a63660fddae8ea1233298694da50ba85e67946fdc832387d5b6aa416f918d2a::bluev {
    struct BLUEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEV>(arg0, 9, b"BLUEV", b"BlueMove TV", b"BLUEV IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/509/813/large/alexandr-anisimov-dendy.jpg?1727775091")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEV>(&mut v2, 3000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

