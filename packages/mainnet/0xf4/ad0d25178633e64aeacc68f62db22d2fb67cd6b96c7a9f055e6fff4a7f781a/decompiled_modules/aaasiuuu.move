module 0xf4ad0d25178633e64aeacc68f62db22d2fb67cd6b96c7a9f055e6fff4a7f781a::aaasiuuu {
    struct AAASIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASIUUU>(arg0, 6, b"AAASIUUU", b"aaa siuuu", b"Can't stop won't stop (thinking about siuuu) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014753_f0bb0e8b39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

