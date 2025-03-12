module 0xe7a33e5e84d12c1d1f5e618d06d7c51b2abeb2672b6f31668865bb219eb6226a::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741771519553.png"));
        let (v1, v2) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 6, b"TT", b"TestToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

