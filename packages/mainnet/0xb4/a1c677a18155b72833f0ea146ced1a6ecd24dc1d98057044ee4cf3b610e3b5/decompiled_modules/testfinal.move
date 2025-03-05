module 0xb4a1c677a18155b72833f0ea146ced1a6ecd24dc1d98057044ee4cf3b610e3b5::testfinal {
    struct TESTFINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTFINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTFINAL>(arg0, 9, b"TESTFINAL", b"TEST FINAL", b"test desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_67c8ab8a62ca55.88567925.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTFINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTFINAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

