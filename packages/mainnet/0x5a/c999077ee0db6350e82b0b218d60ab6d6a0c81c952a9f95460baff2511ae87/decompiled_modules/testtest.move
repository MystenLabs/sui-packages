module 0x5ac999077ee0db6350e82b0b218d60ab6d6a0c81c952a9f95460baff2511ae87::testtest {
    struct TESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742378427491.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<TESTTEST>(arg0, 6, b"TT", b"TestTest", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTEST>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

