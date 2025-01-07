module 0x7bc8a0a6f388c5909205cecfe94893d1b345713a9b4385e74ccdbd839f05dccd::suidol {
    struct SUIDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOL>(arg0, 6, b"SUIDOL", b"Sui Dolphin", b"Join our active community of over 1k members.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_155606_f9361a296e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

