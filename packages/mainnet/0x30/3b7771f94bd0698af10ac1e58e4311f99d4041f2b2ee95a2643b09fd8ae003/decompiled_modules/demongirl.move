module 0x303b7771f94bd0698af10ac1e58e4311f99d4041f2b2ee95a2643b09fd8ae003::demongirl {
    struct DEMONGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMONGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMONGIRL>(arg0, 9, b"DEMONGIRL", b"Demon Girl", b"DEMONGIRL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/048/980/783/large/stasia-bubnova-dg-bubnova-stasia-3.jpg?1651418066")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEMONGIRL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMONGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMONGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

