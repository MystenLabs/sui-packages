module 0x68c9ad687acebb1e40c31b10508af17fb11390600f6a43be5d8b6e69f61a7a31::testb {
    struct TESTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTB>(arg0, 6, b"TESTB", b"testb by SuiAI", b"testb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Capture_b967245a2d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

