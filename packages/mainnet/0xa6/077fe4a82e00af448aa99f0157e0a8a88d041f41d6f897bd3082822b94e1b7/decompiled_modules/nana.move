module 0xa6077fe4a82e00af448aa99f0157e0a8a88d041f41d6f897bd3082822b94e1b7::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 6, b"NANA", b"NANAVO", b"Sui's shark, which will swallow this market. Will start sailing in deep waters and when you least expect it, will be on the surface. A new era will begin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/channels4_profile_53025c7938.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

