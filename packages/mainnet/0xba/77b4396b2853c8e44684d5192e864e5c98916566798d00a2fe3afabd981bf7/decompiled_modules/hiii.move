module 0xba77b4396b2853c8e44684d5192e864e5c98916566798d00a2fe3afabd981bf7::hiii {
    struct HIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIII>(arg0, 6, b"HIII", b"hiii", b"hii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/de3a81e2ecb5642d9334813515acc141713df32dfc4812a7cf8bd9f0b246db91.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIII>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIII>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

