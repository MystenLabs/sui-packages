module 0x6f3a7bdbeff542d2b74a1ae859f539bc07afd00f7c4f4d06606c0f620cd55884::maya {
    struct MAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYA>(arg0, 6, b"MAYA", b"MAYA TOKEN", b"just give maya out to let it flow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735003105479.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

