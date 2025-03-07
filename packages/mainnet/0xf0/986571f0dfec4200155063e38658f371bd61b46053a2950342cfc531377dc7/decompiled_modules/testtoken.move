module 0xf0986571f0dfec4200155063e38658f371bd61b46053a2950342cfc531377dc7::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741341579354.png"));
        let (v1, v2) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 6, b"TT", b"TestToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

