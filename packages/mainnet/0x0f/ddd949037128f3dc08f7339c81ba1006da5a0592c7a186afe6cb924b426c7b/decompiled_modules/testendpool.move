module 0xfddd949037128f3dc08f7339c81ba1006da5a0592c7a186afe6cb924b426c7b::testendpool {
    struct TESTENDPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTENDPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741769008274.png"));
        let (v1, v2) = 0x2::coin::create_currency<TESTENDPOOL>(arg0, 6, b"testendpool", b"testendpool", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTENDPOOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTENDPOOL>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTENDPOOL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTENDPOOL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

