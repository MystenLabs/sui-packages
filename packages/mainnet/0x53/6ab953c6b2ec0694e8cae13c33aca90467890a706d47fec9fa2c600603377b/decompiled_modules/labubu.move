module 0x536ab953c6b2ec0694e8cae13c33aca90467890a706d47fec9fa2c600603377b::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"Labubu on SUI", b"Labubu is a fan meme token that aims to bridge the gap between the real-world excitement of its dedicated fanbase and the vibrant, innovative community of cryptocurrency and meme tokens. As ardent supporters, we seek to harness the energy and enthusi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748859851450.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

