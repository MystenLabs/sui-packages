module 0x9895669e250457828826df9785c8e74e54cd39acbf7e19e614da6a03d3f78fef::obono {
    struct OBONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBONO>(arg0, 9, b"OBONO", b"Obono", b"SUI BULL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/273/391/large/jack-yan-d.jpg?1727162902")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OBONO>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBONO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

