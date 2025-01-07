module 0x593cf64f8bba1ea8f0b0065af988115444d5ced80356504a741db441489cf02a::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 9, b"RED", b"Red", b"RED IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/570/271/large/camila-galarza-red-portrait.jpg?1727911387")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RED>(&mut v2, 3000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}

