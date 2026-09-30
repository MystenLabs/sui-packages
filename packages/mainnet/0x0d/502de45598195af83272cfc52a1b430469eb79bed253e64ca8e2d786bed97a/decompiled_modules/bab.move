module 0xd502de45598195af83272cfc52a1b430469eb79bed253e64ca8e2d786bed97a::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 9, b"bab", b"xbab", b"Money money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAB>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

