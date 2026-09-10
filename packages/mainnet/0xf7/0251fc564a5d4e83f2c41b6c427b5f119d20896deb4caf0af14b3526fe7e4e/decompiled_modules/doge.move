module 0xf70251fc564a5d4e83f2c41b6c427b5f119d20896deb4caf0af14b3526fe7e4e::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"DOGE", b"DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/469586b2512e174d50c40357e99c777487125f4fe13d06aaf34cc8b652f6170c.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGE>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

