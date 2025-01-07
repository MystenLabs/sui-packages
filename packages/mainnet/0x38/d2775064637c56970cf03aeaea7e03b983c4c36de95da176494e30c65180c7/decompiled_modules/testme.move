module 0x38d2775064637c56970cf03aeaea7e03b983c4c36de95da176494e30c65180c7::testme {
    struct TESTME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTME>(arg0, 6, b"TESTME", b"TESTME", b"Welcome To Test Me", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTME>(&mut v2, 80000000000000, @0xa1e5eb06bb08620f23dc1132b997d3a492e6660c12fc4856d17847455aed0d7f, arg1);
        0x2::coin::mint_and_transfer<TESTME>(&mut v2, 20000000000000, @0xa1e5eb06bb08620f23dc1132b997d3a492e6660c12fc4856d17847455aed0d7f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

