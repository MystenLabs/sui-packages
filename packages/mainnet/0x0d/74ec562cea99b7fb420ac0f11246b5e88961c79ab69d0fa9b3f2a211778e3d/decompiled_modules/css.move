module 0xd74ec562cea99b7fb420ac0f11246b5e88961c79ab69d0fa9b3f2a211778e3d::css {
    struct CSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSS>(arg0, 9, b"css", b"cs", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CSS>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSS>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

