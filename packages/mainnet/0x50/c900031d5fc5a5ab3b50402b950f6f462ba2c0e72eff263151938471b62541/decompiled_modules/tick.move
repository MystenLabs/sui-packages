module 0x50c900031d5fc5a5ab3b50402b950f6f462ba2c0e72eff263151938471b62541::tick {
    struct TICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICK>(arg0, 6, b"TICK", b"tick", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICK>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TICK>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

