module 0x2b4e3abde2adc2fb6d3fb5e6bf256667c0c1f3e7b13964bfebab1fb8161bc96d::sunfish {
    struct SUNFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNFISH>(arg0, 6, b"SUNFISH", b"SUN FISH", b"Zero brain, all drip. Floating through life with absolutely no sense of direction but 100% commitment to the vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_12_9eeb232cd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

