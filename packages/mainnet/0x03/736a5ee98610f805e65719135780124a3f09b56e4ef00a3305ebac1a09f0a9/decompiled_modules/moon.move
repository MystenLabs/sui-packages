module 0x3736a5ee98610f805e65719135780124a3f09b56e4ef00a3305ebac1a09f0a9::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"moon", b"moon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

