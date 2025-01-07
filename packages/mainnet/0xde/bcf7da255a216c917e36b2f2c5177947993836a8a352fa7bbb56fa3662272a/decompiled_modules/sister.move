module 0xdebcf7da255a216c917e36b2f2c5177947993836a8a352fa7bbb56fa3662272a::sister {
    struct SISTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISTER>(arg0, 9, b"SISTER", b"Spider Sister", b"SISTER IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/267/246/large/-6-02.jpg?1727138630")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SISTER>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

