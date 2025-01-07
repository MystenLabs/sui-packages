module 0xc788d4d0d59242d9958387f68f1a698491713b8a45735cc4133714ce1e56b07b::testg {
    struct TESTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTG>(arg0, 6, b"Testg", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whitepaper_8918b4ed32.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

