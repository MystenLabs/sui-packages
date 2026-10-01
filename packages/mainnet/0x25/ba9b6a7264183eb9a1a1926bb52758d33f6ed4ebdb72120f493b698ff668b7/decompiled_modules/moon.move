module 0x25ba9b6a7264183eb9a1a1926bb52758d33f6ed4ebdb72120f493b698ff668b7::moon {
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

