module 0xd756f52a2722a7a6e9e0d7d1f6842e4e721bdddacc358593e2afbfceac180de7::testtest {
    struct TESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742377819579.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<TESTTEST>(arg0, 6, b"TT", b"TESTTEST", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTEST>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

