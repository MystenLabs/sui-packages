module 0xdf98033a6e5e69628bed6a1c3a0c3744cceae1b1063fadddb95369e2ad16f81c::llamas {
    struct LLAMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMAS>(arg0, 6, b"LLAMAS", b"LLAMAS SUI", b"take the move ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7083_72be629719.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

