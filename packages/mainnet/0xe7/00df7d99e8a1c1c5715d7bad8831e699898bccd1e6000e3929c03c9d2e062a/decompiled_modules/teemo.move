module 0xe700df7d99e8a1c1c5715d7bad8831e699898bccd1e6000e3929c03c9d2e062a::teemo {
    struct TEEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEMO>(arg0, 9, b"TEEMO", b"Super Teemo", b"TEEMO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/306/873/large/terence-cantal-focal.jpg?1727230864")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEEMO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

